//
//  ShowsCell.swift
//  tvmazetechtest
//
//  Created by David Martin on 15/11/21.
//

import SDWebImage
import UIKit

class ShowsCell: UITableViewCell {
    static let identifier: String = "showsCell"

    @IBOutlet private var viewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var avatarImage: UIImageView!
    @IBOutlet private var nameLabel: UILabel!

    private var heightConstraint: CGFloat = 0 {
        didSet {
            self.viewHeightConstraint.constant = self.heightConstraint
        }
    }

    private var model: Show? {
        didSet {
            self.fillData()
        }
    }

    public func callAsFunction(_ viewHeight: CGFloat, _ model: Show) {
        self.heightConstraint = viewHeight / 1.5
        self.model = model
    }

    private func fillData() {
        guard let model = self.model else { return }

        if let url = URL(string: model.image?.medium ?? "") {
            let placeholderImage = UIImage(named: "placeholder")
            self.avatarImage.sd_setImage(with: url, placeholderImage: placeholderImage, options: .continueInBackground)
        } else {
            let noImage = UIImage(named: "noimage")
            self.avatarImage.image = noImage
        }

        self.nameLabel.text = model.name
    }
}
