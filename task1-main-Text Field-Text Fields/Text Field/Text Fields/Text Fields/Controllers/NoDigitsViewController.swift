//
//  NoDigitsViewController.swift
//  Text Fields
//
//  Created by Антон Заверуха on 19.06.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import UIKit

class NoDigitsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var noDigitsTextField: UITextField!
    var firstProcess = NoDigitsValidator()
    override func viewDidLoad() {
        super.viewDidLoad()
        noDigitsTextField.delegate = self
        noDigitsTextField.backgroundColor = UIColor(red: 0.46, green: 0.46, blue: 0.5, alpha: 0.12)
        noDigitsTextField.layer.cornerRadius = 4
    }
}

extension NoDigitsViewController {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return firstProcess.processFirstTextField(text: textField.text, shouldChangeCharactersIn: range, replacementString: string)
    }
}
