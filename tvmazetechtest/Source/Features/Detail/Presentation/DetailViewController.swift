//
//  DetailViewController.swift
//  tvmazetechtest
//
//  Created by David Martin on 17/11/21.
//

import SDWebImage
import UIKit

class DetailViewController: BaseViewController {
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var avatarImage: UIImageView! {
        didSet {
            self.avatarImage.dropShadow()
        }
    }
    @IBOutlet private var ratingView: UIView! {
        didSet {
            self.ratingView.isHidden = true
            self.ratingView.rounded()
            self.ratingView.dropShadow()
        }
    }
    @IBOutlet private var ratingLabel: UILabel!
    @IBOutlet private var summaryLabel: UILabel!

    @Inject
    var viewModel: DetailViewModel?

    var id: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTitle()
        self.fetch()
    }

    override func viewDidLayoutSubviews() {
        self.scrollView.contentSize = self.view.frame.size
    }

    override func bindViewModels() {
        super.bindViewModels()
        self.viewModel?.model.subscribe { [weak self] response in
            guard let self = self, let model = response else { return }

            Task { @MainActor in
                self.fill(model: model)
            }
        }
    }

    override func unBindViewModels() {
        super.unBindViewModels()
        self.viewModel?.model.unsubscribe()
    }

    private func fetch() {
        guard let id = self.id else { return }
        self.viewModel?.fetch(by: id)
    }
}

// MARK: - Presentation

extension DetailViewController {
    private func initTitle() {
        self.title = NSLocalizedString("detail.title", comment: "Detail of the current show")
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }

    private func fill(model: Show) {
        self.nameLabel.text = model.name

        if let url = URL(string: model.image?.original ?? "") {
            self.avatarImage.sd_setImage(with: url)
        } else {
            let noImage = UIImage(named: "noimage")
            self.avatarImage.image = noImage
        }

        self.ratingView.isHidden = false

        if let rating = model.rating?.average?.description, !rating.isEmpty {
            self.ratingLabel.text = rating
        } else {
            self.ratingLabel.text = "N/A"
        }

        self.summaryLabel.setHTMLFromString(htmlText: model.summary ?? "")
    }
}
