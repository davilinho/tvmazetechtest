//
//  RemoteDatasource.swift
//  tvmazetechtest
//
//  Created by David Martin on 15/11/21.
//

import Alamofire

class RemoteDatasource: InjectableComponent {
    private let baseUrl: String = "https://api.tvmaze.com"

    private let sessionManager: Session = {
      let configuration = URLSessionConfiguration.default
      configuration.timeoutIntervalForRequest = 30
      configuration.requestCachePolicy = .returnCacheDataElseLoad
      return Session(configuration: configuration)
    }()
}

extension RemoteDatasource {
    func get<Response: Codable>(to endpoint: String, with params: Codable?) async throws -> Response {
        let url: String = [self.baseUrl, endpoint].compactMap { $0 }.joined(separator: "/")
        let request = params?.dictionary

        CoreLog.remote.debug("Request: %@", url.description)

        return try await withUnsafeThrowingContinuation { (continuation: UnsafeContinuation<Response, Error>) in
            self.sessionManager
                .request(url, method: .get,
                         parameters: request,
                         encoding: URLEncoding.default,
                         headers: ["Accept": "application/json",
                                   "Content-Type": "application/json"])
                .validate(contentType: ["application/json"])
                .validate(statusCode: 200 ..< 300)
                .responseDecodable(of: Response.self) { response in
                    switch response.result {
                    case let .success(data):
                        continuation.resume(returning: data)
                        return
                    case let .failure(error):
                        continuation.resume(throwing: error)
                        return
                    }
                }
        }
    }
}
