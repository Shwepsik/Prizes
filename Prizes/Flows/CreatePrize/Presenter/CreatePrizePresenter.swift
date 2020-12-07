//
//  CreatePrizePresenter.swift
//  Prizes
//
//  Created by Valerii on 07.12.2020.
//  Copyright (c) 2020 Valerii. All rights reserved.
//

import UIKit

protocol CreatePrizePresenting: AnyObject {

    func presentSomething()
}


    final class CreatePrizePresenter {

        // MARK: - Public properties

        weak var view: CreatePrizeView!
        var router: CreatePrizeRouting!
        var interactor: CreatePrizeInteracting!
    }

// MARK: - Presentation logic

extension CreatePrizePresenter: CreatePrizePresenting {

    func presentSomething() {

        // TODO: Present something in view or call some method on interactor

        // router.navigateToSomewhere()
    }
}

// MARK: - CreatePrizeInteractorOutput

extension CreatePrizePresenter: CreatePrizeInteractorOutput {
    
    func didFailValidatePrice() {
    }
    
    func didFailValidateName() {
    }
}
