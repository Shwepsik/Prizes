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
    func validateEntity()
    
    var prizeEntity: CreatePrizeInteractor.Entity { get }
}

protocol CreatePrizeInteractorOutput: AnyObject {
    func didFailValidatePrice(error: String)
    func didFailValidateName(error: String)
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
        guard let price = Double(price ?? "") else {
            output.didFailValidatePrice(error: "fail")
            return
        }
        
        guard price != 0 else {
            output.didFailValidatePrice(error: "fail")
            return
        }
        
        prizeEntity = CreatePrizeInteractor.Entity(price: price, name: prizeEntity.name)
        validateEntity()
    }
    
    func updateName(name: String?) {
        guard let name = name else {
            output.didFailValidateName(error: "fail")
            return
        }
        
        guard !name.isEmpty else {
            output.didFailValidateName(error: "fail")
            return
        }
        
        prizeEntity = .init(price: prizeEntity.price, name: name)
        validateEntity()
    }
    
    func validateEntity() {
        guard !prizeEntity.name.isEmpty else { return }
        guard prizeEntity.price != 0 else { return }
        output.entityValid()
    }
}
