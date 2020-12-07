//
//  CreatePrizeEntity.swift
//  Prizes
//
//  Created by Valerii on 07.12.2020.
//  Copyright (c) 2020 Valerii. All rights reserved.
//

import Foundation

extension CreatePrizeInteractor {

    struct Entity {
        let price: Double
        let name: String
        
        init(price: Double = 0.0, name: String = "") {
            self.price = price
            self.name = name
        }
    }
}
