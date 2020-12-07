//
//  CreatePrizeView.swift
//  Prizes
//
//  Created by Valerii on 07.12.2020.
//  Copyright (c) 2020 Valerii. All rights reserved.
//

import UIKit

protocol CreatePrizeView: AnyObject {

    func updatePriceWaringLabel(warning: String)
    func updateNameWarningLabel(warning: String)
    func doneBarButton(isEnabled: Bool)
}
