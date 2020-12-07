//
//  CreatePrizeInteractor.swift
//  Prizes
//
//  Created by Valerii on 07.12.2020.
//  Copyright (c) 2020 Valerii. All rights reserved.
//

import Foundation

protocol CreatePrizeInteracting: AnyObject {

    func doSomething()
}

protocol CreatePrizeInteractorOutput: AnyObject {

    func handleSomethingFromInteractor()
}

final class CreatePrizeInteractor {
    
    // MARK: - Public properties
    
    weak var output: CreatePrizeInteractorOutput!
}

// MARK: - Business logic

extension CreatePrizeInteractor: CreatePrizeInteracting {

    func doSomething() {
    
        // NOTE: Do some work

        output?.handleSomethingFromInteractor()
    }
}
