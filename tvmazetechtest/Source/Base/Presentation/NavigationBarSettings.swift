//
//  NavigationBarSettings.swift
//  tvmazetechtest
//
//  Created by David Martin on 15/11/21.
//

import UIKit

public struct NavigationBarSettings {
    public var prefersLargeTitles: Bool = true
    public let backgroundBarColor: UIColor?
    public let barTintColor: UIColor?
    public let titleTextAttributes: [NSAttributedString.Key: Any]?
    public var largeTitleTextAttributes: [NSAttributedString.Key: Any]?

    public init() {
        self.prefersLargeTitles = true
        self.backgroundBarColor = .black
        self.barTintColor = .white

        let tintColor: UIColor = .lightGray
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: tintColor,
            .font: UIFont.boldSystemFont(ofSize: 18.0)
        ]
        self.titleTextAttributes = titleAttributes

        let titleLargeAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: tintColor,
            .font: UIFont.boldSystemFont(ofSize: 32.0)
        ]
        self.largeTitleTextAttributes = titleLargeAttributes
    }
}

extension NavigationBarSettings {
    public init?(navigationBar: UINavigationBar?) {
        guard let navigationBar = navigationBar else { return nil }
        self.prefersLargeTitles = navigationBar.prefersLargeTitles
        self.backgroundBarColor = navigationBar.backgroundColor
        self.barTintColor = navigationBar.barTintColor
        self.titleTextAttributes = navigationBar.titleTextAttributes
        self.largeTitleTextAttributes = navigationBar.largeTitleTextAttributes
    }
}

extension UINavigationBar {
    public func set(settings: NavigationBarSettings) {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = settings.backgroundBarColor
            appearance.titleTextAttributes = settings.titleTextAttributes ?? [:]
            appearance.largeTitleTextAttributes = settings.largeTitleTextAttributes ?? [:]
            self.tintColor = settings.barTintColor
            self.standardAppearance = appearance
            self.compactAppearance = appearance
            self.scrollEdgeAppearance = appearance
        } else {
            self.isOpaque = true
            self.isTranslucent = false
            self.backgroundColor = settings.backgroundBarColor
            self.barTintColor = settings.barTintColor
            self.titleTextAttributes = settings.titleTextAttributes
            self.largeTitleTextAttributes = settings.largeTitleTextAttributes
        }
        self.prefersLargeTitles = settings.prefersLargeTitles
    }
}
