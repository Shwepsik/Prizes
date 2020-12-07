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
    func presenter(_ presenter: CreatePrizePresenting, entity: CreatePrizeInteractor.Entity)
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
        output?.presenter(self, entity: interactor.prizeEntity)
        router.closeViewController()
    }
    
    func cancelBarButtonTapped() {
        router.closeViewController()
    }
}

// MARK: - CreatePrizeInteractorOutput

extension CreatePrizePresenter: CreatePrizeInteractorOutput {
    
    func priceValidationResult(message: String) {
        view.doneBarButton(isEnabled: false)
        view.updatePriceDescriptionLabel(text: message)
    }
    
    func nameValidationResult(message: String) {
        view.doneBarButton(isEnabled: false)
        view.updateNameDescriptionLabel(text: message)
    }
    
    func entityValid() {
        view.doneBarButton(isEnabled: true)
        view.updateNameDescriptionLabel(text: "")
        view.updatePriceDescriptionLabel(text: "")
    }
}
