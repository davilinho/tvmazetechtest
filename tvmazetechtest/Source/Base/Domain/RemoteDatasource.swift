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
    func get<Response: Codable>(to endpoint: String, with params: Codable?, completion: @escaping (Result<Response, BaseError>) -> Void) {
        let url: String = [self.baseUrl, endpoint].compactMap { $0 }.joined(separator: "/")
        let request = params?.dictionary

        CoreLog.remote.debug("Request: %@", url.description)

        self.sessionManager
            .request(url, method: .get,
                     parameters: request,
                     encoding: URLEncoding.default,
                     headers: ["Accept": "application/json",
                               "Content-Type": "application/json"])
            .validate(contentType: ["application/json"])
            .validate(statusCode: 200 ..< 300)
            .responseDecodable(of: Response.self) { response in
                guard let data = response.data, let stringResponse: String = String(data: data, encoding: .utf8),
                      let statusCode = response.response?.statusCode else {
                    completion(.failure(.remoteError(.reason(response.error?.errorDescription ?? "Networking error connection"))))
                    return
                }
                if statusCode < 200 || statusCode > 300 {
                    CoreLog.remote.error("Wrong response received: %@", statusCode)
                }

                CoreLog.remote.debug("Response: %@", stringResponse)

                switch response.result {
                case let .success(data):
                    completion(.success(data))
                case let .failure(error):
                    completion(.failure(.remoteError(.reason(error.localizedDescription))))
                }
            }
    }
}
