//
//  BaseViewController.swift
//  tvmazetechtest
//
//  Created by David Martin on 15/11/21.
//

import UIKit

open class BaseViewController: UIViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.bindViewModels()
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unBindViewModels()
    }

    func bindViewModels() {
        CoreLog.ui.debug("Binding view models")
    }

    func unBindViewModels() {
        CoreLog.ui.debug("Unbinding view models")
    }
}

// MARK: - Private functions

extension BaseViewController {
    private func setupNavigationBar() {
        let settings: NavigationBarSettings = NavigationBarSettings()
        self.navigationController?.navigationBar.set(settings: settings)
    }
}
