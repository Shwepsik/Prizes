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
}
