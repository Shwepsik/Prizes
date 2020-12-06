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
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        priceLabel.text = nil
        checkmarkImage.image = nil
    }
    
    // MARK: - Public
    
    func render(viewModel: ViewModel) {
        nameLabel.text = viewModel.name
        priceLabel.text = viewModel.price
        checkmarkImage.image = viewModel.isSelected ? .checkmark : UIImage()
    }
}

// MARK: - Private

private extension PrizeCell {
    
    func configureCell() {
        nameLabel.textColor = .orange
        priceLabel.textColor = .orange
    }
}

// MARK: - ViewModel

extension PrizeCell {
    
    struct ViewModel {
        let name: String
        let price: String
        let isSelected: Bool
    }
}
 

