//
//  CreatePrizeViewController.swift
//  Prizes
//
//  Created by Valerii on 07.12.2020.
//  Copyright (c) 2020 Valerii. All rights reserved.
//

import UIKit

final class CreatePrizeViewController: UIViewController {

    // MARK: - Public properties

    var presenter: CreatePrizePresenting!

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: Ask the Presenter to do some work
        presenter.presentSomething()
    }
}

// MARK: - View logic

extension CreatePrizeViewController: CreatePrizeView {

    func displaySomething(viewModel: ViewModel) {

        // TODO: Display the result from the Presenter

        // nameTextField.text = viewModel.name
    }
}
