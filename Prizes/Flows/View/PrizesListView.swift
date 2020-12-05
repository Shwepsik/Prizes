//
//  PrizesListView.swift
//  Prizes
//
//  Created by Valerii on 05.12.2020.
//  Copyright (c) 2020 Valerii. All rights reserved.
//

import UIKit

protocol PrizesListView: AnyObject {

    func displaySomething(viewModel: PrizesListViewController.ViewModel)
}

extension PrizesListViewController {
    
    struct ViewModel {
        
        // TODO: Create view model
    }
}
