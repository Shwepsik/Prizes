//
//  PrizesListViewController.swift
//  Prizes
//
//  Created by Valerii on 05.12.2020.
//  Copyright (c) 2020 Valerii. All rights reserved.
//

import UIKit

final class PrizesListViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var availableAmountLabel: UILabel!
    
    // MARK: - Public properties

    var presenter: PrizesListPresenting!

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        presenter.viewDidLoad()
    }
}

// MARK: - UITableViewDataSource

extension PrizesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.prizeCell, for: indexPath)!
        let viewModel = presenter.item(at: indexPath)
        cell.render(viewModel: viewModel)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension PrizesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        presenter.deleteRow(at: indexPath)
    }
}

// MARK: - View logic

extension PrizesListViewController: PrizesListView {
    
    func beginUpdates() {
        tableView.beginUpdates()
    }
    
    func endUpdates() {
        tableView.endUpdates()
    }
    
    func insertRow(at indexPath: IndexPath) {
        tableView.insertRows(at: [indexPath], with: .left)
    }
    
    func deleteRow(at indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .left)
    }
    
    func updateRow(at indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func render(viewModel: ViewModel) {
        availableAmountLabel.text = R.string.localized.availableAmount(viewModel.availableAmount)
    }
}

// MARK: - Private

private extension PrizesListViewController {
    
    func configureView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(R.nib.prizeCell)
        
        availableAmountLabel.textAlignment = .center
        availableAmountLabel.font = R.font.sfProDisplayRegular(size: 22)
        availableAmountLabel.textColor = .orange
    }
}
