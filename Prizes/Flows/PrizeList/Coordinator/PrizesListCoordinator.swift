//
//  PrizesListCoordinator.swift
//  Prizes
//
//  Created by Valerii on 05.12.2020.
//  Copyright (c) 2020 Valerii. All rights reserved.
//

import UIKit

struct PrizesListCoordinator {
    
    func configureFlow() -> PrizesListViewController {
        
        let router = PrizesListRouter()
        let viewController = router.initialViewController()
        router.viewController = viewController
        
        let presenter = PrizesListPresenter()
        presenter.view = viewController
        presenter.router = router
        
        let interactor = PrizesListInteractor()
        interactor.output = presenter
        
        presenter.interactor = interactor
        interactor.persistenceService.delegate = presenter
        
        viewController.presenter = presenter
        
        return viewController
    }
}
