//
//  NavigationBarSettings.swift
//  tvmazetechtest
//
//  Created by David Martin on 15/11/21.
//

import UIKit

public struct NavigationBarSettings {
    public var prefersLargeTitles: Bool = true
    public var backgroundBarColor: UIColor?
    public var barTintColor: UIColor?
    public var titleTextAttributes: [NSAttributedString.Key: Any] = [:]
    public var largeTitleTextAttributes: [NSAttributedString.Key: Any] = [:]

    public init() {
        self.prefersLargeTitles = true
        self.backgroundBarColor = .black
        self.barTintColor = .white

        let tintColor: UIColor = .white
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

extension UINavigationBar {
    public func set(settings: NavigationBarSettings) {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = settings.backgroundBarColor
        appearance.titleTextAttributes = settings.titleTextAttributes
        appearance.largeTitleTextAttributes = settings.largeTitleTextAttributes
        self.tintColor = settings.barTintColor
        self.standardAppearance = appearance
        self.compactAppearance = appearance
        self.scrollEdgeAppearance = appearance
        self.prefersLargeTitles = settings.prefersLargeTitles
    }
}
