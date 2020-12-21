//
//  UIAlertController+Extension.swift
//  Prizes
//
//  Created by Valerii on 21.12.2020.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    struct ViewModel {
        let title: String?
        let message: String
        let actions: [UIAlertAction]
        let style: Style
        
        init(title: String? = nil, message: String, actions: [UIAlertAction], style: Style = .alert) {
            self.title = title
            self.message = message
            self.actions = actions
            self.style = style
        }
    }
}
