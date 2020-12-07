//
//  CreatePrizeRouter.swift
//  Prizes
//
//  Created by Valerii on 07.12.2020.
//  Copyright (c) 2020 Valerii. All rights reserved.
//

import UIKit

protocol CreatePrizeRouting {
    func initialViewController() -> CreatePrizeViewController
    func closeViewController()
}

final class CreatePrizeRouter {
    
    // MARK: - Public properties
    
    weak var viewController: CreatePrizeViewController!
}

// MARK: - Navigation

extension CreatePrizeRouter: CreatePrizeRouting {    
        
    func initialViewController() -> CreatePrizeViewController {
        let controller = CreatePrizeViewController(nib: R.nib.createPrize)
        return controller
    }
    
    func closeViewController() {
        viewController.dismiss(animated: true)
    }
}
