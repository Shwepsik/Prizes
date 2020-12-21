//
//  PrizesListEntity.swift
//  Prizes
//
//  Created by Valerii on 05.12.2020.
//  Copyright (c) 2020 Valerii. All rights reserved.
//

import Foundation

extension PrizesListInteractor {
    
    struct Entity {
        let name: String
        let price: Double
        let uuid: UUID
        var isSelected: Bool
        let date: Date
        
        init(name: String, price: Double, uuid: UUID = UUID(), isSelected: Bool = false, date: Date = Date()) {
            self.name = name
            self.price = price
            self.uuid = uuid
            self.isSelected = isSelected
            self.date = date
        }
    }
}

// MARK: - Equatable

extension PrizesListInteractor.Entity: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
