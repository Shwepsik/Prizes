//
//  CreatePrizePresenter.swift
//  Prizes
//
//  Created by Valerii on 07.12.2020.
//  Copyright (c) 2020 Valerii. All rights reserved.
//

import UIKit

protocol CreatePrizePresenting: AnyObject {
    func priceTextFieldDidUpdateValue(price: String?)
    func nameTextFieldDidUpdateValue(name: String?)
    
    func doneBarButtonTapped()
    func cancelBarButtonTapped()
}

protocol CreatePrizePresentingOutput: AnyObject {

    func presenter(_ presenter: CreatePrizePresenting, prize: CreatePrizeInteractor.Entity)
}

final class CreatePrizePresenter {
    
    // MARK: - Public properties
    
    weak var view: CreatePrizeView!
    var router: CreatePrizeRouting!
    var interactor: CreatePrizeInteracting!
    
    weak var output: CreatePrizePresentingOutput?
}

// MARK: - Presentation logic

extension CreatePrizePresenter: CreatePrizePresenting {
    
    func priceTextFieldDidUpdateValue(price: String?) {
        interactor.updatePrice(price: price)
    }
    
    func nameTextFieldDidUpdateValue(name: String?) {
        interactor.updateName(name: name)
    }
    
    func doneBarButtonTapped() {
        output?.presenter(self, prize: interactor.prizeEntity)
        router.closeViewController()
    }
    
    func cancelBarButtonTapped() {
        router.closeViewController()
    }
}

// MARK: - CreatePrizeInteractorOutput

extension CreatePrizePresenter: CreatePrizeInteractorOutput {
    
    func didFailValidatePrice(error: String) {
        view.doneBarButton(isEnabled: false)
        view.updatePriceWaringLabel(warning: error)
    }
    
    func didFailValidateName(error: String) {
        view.doneBarButton(isEnabled: false)
        view.updateNameWarningLabel(warning: error)
    }
    
    func entityValid() {
        view.doneBarButton(isEnabled: true)
    }
}
