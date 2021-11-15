//
//  CoreLog.swift
//  tvmazetechtest
//
//  Created by David Martin on 15/11/21.
//

import os.log

public class CoreLog {
    public let identifier: String
    public let category: String
    public let internalLog: OSLog?

    public init(identifier: String = "", category: String = "") {
        self.identifier = identifier
        self.category = category
        if !identifier.isEmpty, !category.isEmpty {
            self.internalLog = OSLog(subsystem: identifier, category: category)
        } else {
            self.internalLog = nil
        }
    }

    private func log(_ message: StaticString, _ type: OSLogType, _ args: CVarArg...) {
        os_log(message, log: self.internalLog ?? .default, type: type, args)
    }

    public func info(_ message: StaticString, _ args: CVarArg...) {
        self.log(message, .info, args)
    }

    public func debug(_ message: StaticString, _ args: CVarArg...) {
        self.log(message, .debug, args)
    }

    public func error(_ message: StaticString, _ args: CVarArg...) {
        self.log(message, .error, args)
    }

    public func fault(_ message: StaticString, _ args: CVarArg...) {
        self.log(message, .fault, args)
    }
}

extension CoreLog {
    public static let business = CoreLog(identifier: CoreLog.init().identifier, category: "business")
    public static let ui = CoreLog(identifier: CoreLog.init().identifier, category: "ui")
    public static let firebase = CoreLog(identifier: CoreLog.init().identifier, category: "firebase")
    public static let remote = CoreLog(identifier: CoreLog.init().identifier, category: "remote")
}
