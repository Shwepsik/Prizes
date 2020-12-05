//
//  PrizesListInteractor.swift
//  Prizes
//
//  Created by Valerii on 05.12.2020.
//  Copyright (c) 2020 Valerii. All rights reserved.
//

import Foundation

protocol PrizesListInteracting: AnyObject {

    func doSomething()
}

protocol PrizesListInteractorOutput: AnyObject {

    func handleSomethingFromInteractor()
}

final class PrizesListInteractor {
    
    // MARK: - Public properties
    
    weak var output: PrizesListInteractorOutput!
}

// MARK: - Business logic

extension PrizesListInteractor: PrizesListInteracting {

    func doSomething() {
    
        // NOTE: Do some work

        output?.handleSomethingFromInteractor()
    }
}
