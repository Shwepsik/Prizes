//
//  CreatePrizeInteractor.swift
//  Prizes
//
//  Created by Valerii on 07.12.2020.
//  Copyright (c) 2020 Valerii. All rights reserved.
//

import Foundation

protocol CreatePrizeInteracting: AnyObject {
    func updatePrice(price: Double)
    func updateName(name: String)
    func validateEntity()
}

protocol CreatePrizeInteractorOutput: AnyObject {
    func didFailValidatePrice()
    func didFailValidateName()
}

final class CreatePrizeInteractor {
    
    // MARK: - Public properties
    
    weak var output: CreatePrizeInteractorOutput!
    
    private(set) var prizeEntity: CreatePrizeInteractor.Entity = .init()
}

// MARK: - Business logic

extension CreatePrizeInteractor: CreatePrizeInteracting {
    
    func updatePrice(price: Double) {
        guard price != 0 else {
            output.didFailValidatePrice()
            return
        }
        
        prizeEntity = CreatePrizeInteractor.Entity(price: price, name: prizeEntity.name)
    }
    
    func updateName(name: String) {
        guard !name.isEmpty else {
            output.didFailValidateName()
            return
        }
        prizeEntity = .init(price: prizeEntity.price, name: name)
    }
    
    func validateEntity() {
        guard !prizeEntity.name.isEmpty else {
            output.didFailValidateName()
            return
        }
        
        guard prizeEntity.price != 0 else {
            output.didFailValidatePrice()
            return
        }
    }
}
