//
//  PrizesListPresenter.swift
//  Prizes
//
//  Created by Valerii on 05.12.2020.
//  Copyright (c) 2020 Valerii. All rights reserved.
//

import UIKit

protocol PrizesListPresenting: AnyObject {
    func numberOfRows(in section: Int) -> Int
    func item(at indexPath: IndexPath)
    func deleteRow(at indexPath: IndexPath)
    func didSelectRow(at indexPath: IndexPath)
    
    func viewDidLoad()
}

final class PrizesListPresenter {
    
    // MARK: - Public properties
    
    weak var view: PrizesListView!
    var router: PrizesListRouting!
    var interactor: PrizesListInteracting!
}

// MARK: - Presentation logic

extension PrizesListPresenter: PrizesListPresenting {
    
    func numberOfRows(in section: Int) -> Int {
        interactor.numberOfRows(in: section)
    }
    
    func item(at indexPath: IndexPath) {
        interactor.item(at: indexPath)
    }
    
    func deleteRow(at indexPath: IndexPath) {
        interactor.deleteRow(at: indexPath)
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        interactor.didSelectRow(at: indexPath)
    }
    
    func viewDidLoad() {
        interactor.saveDefaultPrizes()
    }
}

// MARK: - PrizesListInteractorOutput

extension PrizesListPresenter: PrizesListInteractorOutput {
    
    func expensivePrizeSelected() {
    }
}

// MARK: - PersistenceServiceDelegate

extension PrizesListPresenter: PersistenceServiceDelegate {
    
    func controllerWillChangeContent(_ persistenceService: PersistenceService) {
    }
    
    func controllerDidChangeContent(_ persistenceService: PersistenceService) {
    }
    
    func controllerProcessingUpdate(_ persistenceService: PersistenceService, type: PersistenceService.BatchUpdate) {
    }
}
