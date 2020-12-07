//
//  CreatePrizeCoordinator.swift
//  Prizes
//
//  Created by Valerii on 07.12.2020.
//  Copyright (c) 2020 Valerii. All rights reserved.
//

import UIKit

struct CreatePrizeCoordinator {
    
    func configureFlow() -> CreatePrizeViewController {
        
        let router = CreatePrizeRouter()
        let viewController = router.initialViewController()
        router.viewController = viewController
        
        let presenter = CreatePrizePresenter()
        presenter.view = viewController
        presenter.router = router
        
        let interactor = CreatePrizeInteractor()
        interactor.output = presenter
        
        presenter.interactor = interactor
        
        viewController.presenter = presenter
        
        return viewController
    }
}
