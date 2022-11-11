//
//  InputMaskViewController.swift
//  Text Fields
//
//  Created by Антон Заверуха on 20.06.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import UIKit

protocol InputMaskValidatorTextFieldAddHyphenDelegate: AnyObject {
    func addHyphen(string: String, text: String)
}

protocol InputMaskValidatorTextFieldRemoveHyphenDelegate: AnyObject {
    func removeHyphen()
}

class InputMaskViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var inputMaskTextField: UITextField!
    var thirdProcess = InputMaskValidator()
    override func viewDidLoad() {
        super.viewDidLoad()
        thirdProcess.inputMaskValidatorTextFieldAddHyphenDelegate = self
        thirdProcess.inputMaskValidatorTextFieldRemoveHyphenDelegate = self
        inputMaskTextField.delegate = self
        inputMaskTextField.backgroundColor = UIColor(red: 0.46, green: 0.46, blue: 0.5, alpha: 0.12)
        inputMaskTextField.layer.cornerRadius = 4
    }
}

extension InputMaskViewController: InputMaskValidatorTextFieldAddHyphenDelegate, InputMaskValidatorTextFieldRemoveHyphenDelegate {
    func removeHyphen() {
        inputMaskTextField.text?.removeLast(2)
    }
    
    func addHyphen(string: String, text: String) {
        inputMaskTextField.text = text + string  + "-"
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return thirdProcess.processThirdTextField(text: textField.text, shouldChangeCharactersIn: range, replacementString: string)
    }
}
