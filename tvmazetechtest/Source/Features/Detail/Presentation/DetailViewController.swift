//
//  DetailViewController.swift
//  tvmazetechtest
//
//  Created by David Martin on 17/11/21.
//

import SDWebImage
import UIKit

class DetailViewController: BaseViewController {
    @IBOutlet private var nameLabel: UILabel!

    @IBOutlet private var avatarImage: UIImageView!

    @IBOutlet private var ratingView: UIView! {
        didSet {
            self.ratingView.rounded()
        }
    }

    @IBOutlet private var ratingLabel: UILabel!

    @IBOutlet private var summaryLabel: UILabel!

    @Inject
    private var viewModel: DetailViewModel

    var id: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTitle()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.fetch()
    }

    override func bindViewModels() {
        super.bindViewModels()
        self.viewModel.model.subscribe { [weak self] response in
            guard let self = self, let model = response else { return }
            self.fill(model: model)
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

// MARK: - Presentation

extension DetailViewController {
    private func initTitle() {
        self.title = "Show detail"
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }

    private func fill(model: Show) {
        self.nameLabel.text = model.name

        if let url = URL(string: model.image?.original ?? "") {
            let placeholderImage = UIImage(named: "placeholder")
            self.avatarImage.sd_setImage(with: url, placeholderImage: placeholderImage, options: .continueInBackground)
        }

        self.ratingLabel.text = model.rating?.average?.description
        self.summaryLabel.setHTMLFromString(htmlText: model.summary ?? "")
    }
}

extension UILabel {
    func setHTMLFromString(htmlText: String) {
        let modifiedFont = String(format: "<div style=\"text-align: center;\"><span style=\"font-family: '-apple-system', 'Verdana'; color: '#E0E0E0'; font-size: 16;\">%@</span></div>", htmlText)
        if let attrStr = try? NSAttributedString(data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
                                                 options: [.documentType: NSAttributedString.DocumentType.html,
                                                           .characterEncoding: String.Encoding.utf8.rawValue],
                                                 documentAttributes: nil) {
            self.attributedText = attrStr
        }
    }
}
