//
//  CreatePrizeView.swift
//  Prizes
//
//  Created by Valerii on 07.12.2020.
//  Copyright (c) 2020 Valerii. All rights reserved.
//

import UIKit

protocol CreatePrizeView: AnyObject {

    func updatePriceDescriptionLabel(text: String)
    func updateNameDescriptionLabel(text: String)
    func doneBarButton(isEnabled: Bool)
}
