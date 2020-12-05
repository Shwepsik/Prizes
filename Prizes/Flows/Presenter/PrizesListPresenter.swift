//
//  PrizesListPresenter.swift
//  Prizes
//
//  Created by Valerii on 05.12.2020.
//  Copyright (c) 2020 Valerii. All rights reserved.
//

import UIKit

protocol PrizesListPresenting: AnyObject {

    func presentSomething()
}

final class PrizesListPresenter {
    
    // MARK: - Public properties
    
    weak var view: PrizesListView!
    var router: PrizesListRouting!
    var interactor: PrizesListInteracting!
}

// MARK: - Presentation logic

extension PrizesListPresenter: PrizesListPresenting {

    func presentSomething() {

        // TODO: Present something in view or call some method on interactor

        // router.navigateToSomewhere()
    }
}

// MARK: - PrizesListInteractorOutput

extension PrizesListPresenter: PrizesListInteractorOutput {

    func handleSomethingFromInteractor() {

        // TODO: Format the response from the Interactor and pass the result back to the view

        // let viewModel = PrizesListViewController.ViewModel()
        // view.displaySomething(viewModel: viewModel)
    }
}
