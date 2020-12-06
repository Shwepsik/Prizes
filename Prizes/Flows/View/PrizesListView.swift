//
//  PrizesListView.swift
//  Prizes
//
//  Created by Valerii on 05.12.2020.
//  Copyright (c) 2020 Valerii. All rights reserved.
//

import UIKit

protocol PrizesListView: AnyObject {
    func beginUpdates()
    func endUpdates()
    func insertRow(at indexPath: IndexPath)
    func deleteRow(at indexPath: IndexPath)
    func updateRow(at indexPath: IndexPath)
    
    func render(viewModel: PrizesListViewController.ViewModel)
}

extension PrizesListViewController {
    
    struct ViewModel {
        let availableAmount: String
    }
}
