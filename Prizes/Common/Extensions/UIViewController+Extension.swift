//
//  UIViewController+Extension.swift
//  Prizes
//
//  Created by Valerii on 07.12.2020.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertController(with viewModel: UIViewController.AlertViewModel? = nil,
                             style: UIAlertController.Style,
                             actions: [UIAlertAction]) {
        
        let alertController = UIAlertController(title: viewModel?.title,
                                                message: viewModel?.message,
                                                preferredStyle: style)
        
        actions.forEach { alertController.addAction($0) }
        present(alertController, animated: true)
    }
}

// MARK: - ViewModel

extension UIViewController {
    
    struct AlertViewModel {
        let title: String?
        let message: String
        
        init(title: String? = nil, message: String) {
            self.title = title
            self.message = message
        }
    }
}
