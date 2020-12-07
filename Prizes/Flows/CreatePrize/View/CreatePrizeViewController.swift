//
//  CreatePrizeViewController.swift
//  Prizes
//
//  Created by Valerii on 07.12.2020.
//  Copyright (c) 2020 Valerii. All rights reserved.
//

import UIKit

final class CreatePrizeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var nameDescriptionLabel: UILabel!
    
    @IBOutlet private var priceTextField: UITextField!
    @IBOutlet private var priceDescriptionLabel: UILabel!
        
    // MARK: - Public properties

    var presenter: CreatePrizePresenting!
    
    // MARK: - Private properties

    private var doneBarButton: UIBarButtonItem!
    private var cancelBarButton: UIBarButtonItem!
    private var toolBar: UIToolbar!

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureToolBar()
        configureView()
        configureNavigationBar()
    }
}

// MARK: - View logic

extension CreatePrizeViewController: CreatePrizeView {
    
    func updatePriceDescriptionLabel(text: String) {
        priceDescriptionLabel.text = text
        priceDescriptionLabel.textColor = R.color.primaryError() 
    }
    
    func updateNameDescriptionLabel(text: String) {
        nameDescriptionLabel.text = text
        nameDescriptionLabel.textColor = R.color.primaryError()
    }
    
    func doneBarButton(isEnabled: Bool) {
        doneBarButton.isEnabled = isEnabled
    }
}

// MARK: - Actions

private extension CreatePrizeViewController {
    
    @objc
    func doneBarButtonAction() {
        view.endEditing(true)
        presenter.doneBarButtonTapped()
    }
    
    @objc
    func cancelBarButtonAction() {
        view.endEditing(true)
        presenter.cancelBarButtonTapped()
    }
    
    @objc
    func toolBarDoneAction() {
        view.endEditing(true)
    }
}

// MARK: - Private

private extension CreatePrizeViewController {
    
    @objc
    func textFieldDidUpdateValue(_ textField: UITextField) {
        if textField == priceTextField {
            presenter.priceTextFieldDidUpdateValue(price: textField.text)
        } else if textField == nameTextField {
            presenter.nameTextFieldDidUpdateValue(name: textField.text)
        }
    }
    
    func configureView() {
        nameTextField.placeholder = R.string.localized.enterName()
        nameDescriptionLabel.textColor = R.color.systemBackgroundColor()
        nameDescriptionLabel.font = AppFont.titleSmall
        nameDescriptionLabel.text = R.string.localized.requiredField()
        
        priceTextField.placeholder = R.string.localized.enterPrice()
        priceTextField.keyboardType = .decimalPad
        priceDescriptionLabel.textColor =  R.color.systemBackgroundColor()
        priceDescriptionLabel.font = AppFont.titleSmall
        priceDescriptionLabel.text = R.string.localized.requiredField()
        
        priceTextField.addTarget(self, action: #selector(textFieldDidUpdateValue(_:)), for: .editingChanged)
        priceTextField.inputAccessoryView = toolBar
        
        nameTextField.addTarget(self, action: #selector(textFieldDidUpdateValue(_:)), for: .editingChanged)
        nameTextField.inputAccessoryView = toolBar
    }
    
    func configureNavigationBar() {
        doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
                                        target: self,
                                        action: #selector(doneBarButtonAction))

        navigationItem.rightBarButtonItem = doneBarButton
        doneBarButton.isEnabled = false
        
        cancelBarButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                          target: self,
                                          action: #selector(cancelBarButtonAction))
        navigationItem.leftBarButtonItem = cancelBarButton
        
        title = R.string.localized.createPrize()
    }

    func configureToolBar() {
        toolBar = UIToolbar(
            frame: .init(origin: .zero, size: .init(width: UIScreen.main.bounds.width, height: 44))
        )

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace,
                                            target: nil,
                                            action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(toolBarDoneAction))
        
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
    }
}
