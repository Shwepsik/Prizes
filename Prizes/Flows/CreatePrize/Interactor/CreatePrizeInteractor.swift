//
//  CreatePrizeInteractor.swift
//  Prizes
//
//  Created by Valerii on 07.12.2020.
//  Copyright (c) 2020 Valerii. All rights reserved.
//

import Foundation

protocol CreatePrizeInteracting: AnyObject {
    func updatePrice(price: String?)
    func updateName(name: String?)
    
    var prizeEntity: CreatePrizeInteractor.Entity { get }
}

protocol CreatePrizeInteractorOutput: AnyObject {
    func priceValidationResult(message: String)
    func nameValidationResult(message: String)
    func entityValid()
}

final class CreatePrizeInteractor {
    
    // MARK: - Public properties
    
    weak var output: CreatePrizeInteractorOutput!
    private(set) var prizeEntity: CreatePrizeInteractor.Entity = .init()
}

// MARK: - Business logic

extension CreatePrizeInteractor: CreatePrizeInteracting {
    
    func updatePrice(price: String?) {
        guard let price = price else { return }
        prizeEntity = .init(price: Double(price) ?? 0.0, name: prizeEntity.name)
        
        guard !price.isEmpty else {
            output.priceValidationResult(message: R.string.localized.priceCantBeEmpty())
            return
        }
        
        guard let doublePrice = Double(price) else {
            output.priceValidationResult(message: R.string.localized.incorectTextInput())
            return
        }
            
        guard doublePrice != 0 else {
            output.priceValidationResult(message: R.string.localized.priceCantBeEqualToZero())
            return
        }
        output.priceValidationResult(message: "")
        
        validateEntity()
    }
    
    func updateName(name: String?) {
        guard let name = name else { return }
        prizeEntity = .init(price: prizeEntity.price, name: name)
        
        guard !name.isEmpty else {
            output.nameValidationResult(message: R.string.localized.nameCantBeEmpty())
            return
        }
        output.nameValidationResult(message: "")
        
        validateEntity()
    }
}

// MARK: - Private

private extension CreatePrizeInteractor {
    
    func validateEntity() {
        guard !prizeEntity.name.isEmpty else { return }
        guard prizeEntity.price != 0 else { return }
        output.entityValid()
    }
}
