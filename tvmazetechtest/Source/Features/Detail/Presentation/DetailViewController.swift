//
//  DetailViewController.swift
//  tvmazetechtest
//
//  Created by David Martin on 17/11/21.
//

import UIKit

class DetailViewController: BaseViewController {
    @IBOutlet private var name: UILabel!

    @Inject
    var viewModel: DetailViewModel

    var id: Int?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.fetch()
    }

    override func bindViewModels() {
        super.bindViewModels()
        self.viewModel.model.subscribe { [weak self] response in
            guard let self = self, let model = response else { return }
            self.name.text = model.name
        }
    }

    override func unBindViewModels() {
        super.unBindViewModels()
        self.viewModel.model.unsubscribe()
    }

    private func fetch() {
        guard let id = self.id else { return }
        self.viewModel.fetch(by: id)
    }
}
