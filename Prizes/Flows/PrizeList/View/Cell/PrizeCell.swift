//
//  PrizeCell.swift
//  Prizes
//
//  Created by Valerii on 07.12.2020.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

final class PrizeCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private var checkmarkImage: UIImageView!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        priceLabel.text = nil
    }
    
    // MARK: - Public
    
    func render(viewModel: ViewModel) {
        nameLabel.text = viewModel.name
        priceLabel.text = viewModel.price
        checkmarkImage.isHidden = !viewModel.isSelected
    }
}

// MARK: - Private

private extension PrizeCell {
    
    func configureCell() {
        nameLabel.font = AppFont.titleNormal
        nameLabel.textColor = R.color.primaryOrange()
        priceLabel.textColor = R.color.primaryOrange()
        priceLabel.font = AppFont.titleNormal
        checkmarkImage.image = .checkmark
    }
}

// MARK: - ViewModel

extension PrizeCell {
    
    struct ViewModel {
        let name: String
        let price: String
        let isSelected: Bool
        let height: CGFloat = 55
    }
}
 

