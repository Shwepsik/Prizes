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
    func item(at indexPath: IndexPath) -> PrizeCell.ViewModel
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
    
    func item(at indexPath: IndexPath) -> PrizeCell.ViewModel {
        let item = interactor.item(at: indexPath)
        let viewModel: PrizeCell.ViewModel = .init(
            name: item.name,
            price: String(item.price),
            isSelected: item.isSelected
        )
        return viewModel
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
        presentOverchargesAlert()
    }
    
    func updateAvailableAmount(amount: Double) {
        view.render(viewModel: .init(availableAmount: String(amount)))
    }
}

// MARK: - PersistenceServiceDelegate

extension PrizesListPresenter: PersistenceServiceDelegate {
    
    func controllerWillChangeContent(_ persistenceService: PersistenceService) {
        view.beginUpdates()
    }
    
    func controllerDidChangeContent(_ persistenceService: PersistenceService) {
        view.endUpdates()
    }
    
    func controllerProcessingUpdate(_ persistenceService: PersistenceService, type: PersistenceService.BatchUpdate) {
        switch type {
        case .insert(let indexPath):
            view.insertRow(at: indexPath)
        case .delete(let indexPath):
            view.deleteRow(at: indexPath)
        case .update(let indexPath):
            view.updateRow(at: indexPath)
        }
    }
}

// MARK: - Private

private extension PrizesListPresenter {
    
    func presentOverchargesAlert() {
        let okAction = UIAlertAction(title: R.string.localized.ok(), style: .default) { _ in }
        
        router.presentAlertController(with: .init(
            message: R.string.localized.overchargesDescription()),
            style: .alert,
            actions: [okAction]
        )
    }
}
