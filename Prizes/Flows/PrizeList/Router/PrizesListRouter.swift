//
//  PrizesListRouter.swift
//  Prizes
//
//  Created by Valerii on 05.12.2020.
//  Copyright (c) 2020 Valerii. All rights reserved.
//

import UIKit

protocol PrizesListRouting {

    func initialViewController() -> PrizesListViewController
    func presentAlertController(with viewModel: UIViewController.AlertViewModel?,
                                style: UIAlertController.Style,
                                actions: [UIAlertAction])
    func navigateToCreatePrizeScreen()
}

final class PrizesListRouter {
    
    // MARK: - Public properties
    
    weak var viewController: PrizesListViewController!
}

// MARK: - Navigation

extension PrizesListRouter: PrizesListRouting {
        
    func initialViewController() -> PrizesListViewController {
        let controller = PrizesListViewController(nib: R.nib.prizesList)
        return controller
    }
    
    func presentAlertController(with viewModel: UIViewController.AlertViewModel?,
                                style: UIAlertController.Style,
                                actions: [UIAlertAction]) {
        viewController.showAlertController(with: viewModel,
                                           style: style,
                                           actions: actions)
    }
    
    func navigateToCreatePrizeScreen() {
        let controller = CreatePrizeCoordinator().configureFlow()
        viewController.present(controller, animated: true)
    }
}