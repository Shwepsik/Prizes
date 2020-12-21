//
//  UIViewController+Extension.swift
//  Prizes
//
//  Created by Valerii on 07.12.2020.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertController(with viewModel: UIAlertController.ViewModel) {
        
        let alertController = UIAlertController(title: viewModel.title,
                                                message: viewModel.message,
                                                preferredStyle: viewModel.style)
        
        viewModel.actions.forEach { alertController.addAction($0) }
        present(alertController, animated: true)
    }
}
