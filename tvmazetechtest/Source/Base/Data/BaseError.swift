//
//  BaseError.swift
//  tvmazetechtest
//
//  Created by David Martin on 15/11/21.
//

import Foundation

public enum BaseError: Error {
    case repositoryError(RepositoryError)
    case remoteError(RemoteError)
    case ui(UIError)

    public enum RepositoryError {
        case reason(String)

        var description: String {
            switch self {
            case let .reason(reason):
                return "Reason: \(reason)"
            }
        }
    }

    public enum RemoteError {
        case reason(String)

        var description: String {
            switch self {
            case let .reason(reason):
                return "Reason: \(reason)"
            }
        }
    }

    public enum UIError {
        case reason(String)

        var description: String {
            switch self {
            case let .reason(reason):
                return "Reason: \(reason)"
            }
        }
    }

    var description: String {
        switch self {
        case let .repositoryError(error):
            return "RepositoryError - " + error.description
        case let .remoteError(error):
            return "RemoteError - " + error.description
        case let .ui(error):
            return "UIError - " + error.description
        }
    }
}
