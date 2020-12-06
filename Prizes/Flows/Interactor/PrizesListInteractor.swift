//
//  PrizesListInteractor.swift
//  Prizes
//
//  Created by Valerii on 05.12.2020.
//  Copyright (c) 2020 Valerii. All rights reserved.
//

import Foundation

protocol PrizesListInteracting: AnyObject {
    func numberOfRows(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> PrizesListInteractor.PrizeEntity
    func deleteRow(at indexPath: IndexPath)
    func didSelectRow(at indexPath: IndexPath)
        
    func saveDefaultPrizes()
}

protocol PrizesListInteractorOutput: AnyObject {
    func expensivePrizeSelected()
}

final class PrizesListInteractor {
    
    // MARK: - Public properties
    
    weak var output: PrizesListInteractorOutput!
    let persistenceService: PersistenceStore
    
    // MARK: - Private properties
    
    private var defaultPrizes = [
        PrizeEntity(name: R.string.localized.tShirt(), price: 15),
        PrizeEntity(name: R.string.localized.sneakers(), price: 30),
        PrizeEntity(name: R.string.localized.headphones(), price: 35),
        PrizeEntity(name: R.string.localized.shorts(), price: 10),
        PrizeEntity(name: R.string.localized.cap(), price: 15),
        PrizeEntity(name: R.string.localized.phone(), price: 100),
        PrizeEntity(name: R.string.localized.car(), price: 1000),
        PrizeEntity(name: R.string.localized.ball(), price: 25)
    ]
    private let maxAmountAvailable: Double = 100
    
    // MARK: - Init
    
    init(persistenceService: PersistenceStore = PersistenceService()) {
        self.persistenceService = persistenceService
    }
}

// MARK: - Business logic

extension PrizesListInteractor: PrizesListInteracting {
    
    func numberOfRows(in section: Int) -> Int {
        let sectionData = persistenceService.fetchedResultsController.sections?[section]
        return sectionData?.numberOfObjects ?? 0
    }
    
    func item(at indexPath: IndexPath) -> PrizeEntity {
        let item = persistenceService.fetch(at: indexPath)
        return item
    }
    
    func deleteRow(at indexPath: IndexPath) {
        persistenceService.delete(at: indexPath)
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let entity = item(at: indexPath)
        
        guard entity.price < maxAmountAvailable else {
            output.expensivePrizeSelected()
            return
        }
        
        persistenceService.updateRecord(entity: entity)
        
        var prizes = persistenceService.fetchSelectedObjects()
        let prizesAmount = prizes.map { $0.price }.reduce(0, +)
        
        guard prizesAmount > maxAmountAvailable else { return }
        var overcharges = prizesAmount - maxAmountAvailable
        
        prizes = prizes.filter { $0 != entity }
        
        for prize in prizes {
            overcharges -= prize.price
            persistenceService.updateRecord(entity: prize)
            guard overcharges <= 0 else { continue }
            break
        }
    }
    
    func saveDefaultPrizes() {
        guard persistenceService.isRecordsAreEmpty() else { return }
        defaultPrizes = defaultPrizes.sorted(by: { $0.price < $1.price })
        defaultPrizes.forEach { persistenceService.save(entity: $0) }
    }
}
