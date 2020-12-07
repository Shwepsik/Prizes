//
//  CreatePrizePresenter.swift
//  Prizes
//
//  Created by Valerii on 07.12.2020.
//  Copyright (c) 2020 Valerii. All rights reserved.
//

import UIKit

protocol CreatePrizePresenting: AnyObject {
    func priceTextFieldDidUpdateValue(price: Double?)
    func nameTextFieldDidUpdateValue(name: String?)
}

final class CreatePrizePresenter {
    
    // MARK: - Public properties
    
    weak var view: CreatePrizeView!
    var router: CreatePrizeRouting!
    var interactor: CreatePrizeInteracting!
}

// MARK: - Presentation logic

extension CreatePrizePresenter: CreatePrizePresenting {
    
    func priceTextFieldDidUpdateValue(price: Double?) {
        interactor.updatePrice(price: price)
    }
    
    func nameTextFieldDidUpdateValue(name: String?) {
        interactor.updateName(name: name)
    }
}

// MARK: - CreatePrizeInteractorOutput

extension CreatePrizePresenter: CreatePrizeInteractorOutput {
    
    func didFailValidatePrice() {
    }
    
    func didFailValidateName() {
    }
}
