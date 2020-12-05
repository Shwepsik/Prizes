//
//  PrizesListViewController.swift
//  Prizes
//
//  Created by Valerii on 05.12.2020.
//  Copyright (c) 2020 Valerii. All rights reserved.
//

import UIKit

final class PrizesListViewController: UIViewController {

    // MARK: - Public properties

    var presenter: PrizesListPresenting!

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: Ask the Presenter to do some work
        presenter.presentSomething()
    }
}

// MARK: - View logic

extension PrizesListViewController: PrizesListView {

    func displaySomething(viewModel: ViewModel) {

        // TODO: Display the result from the Presenter

        // nameTextField.text = viewModel.name
    }
}
