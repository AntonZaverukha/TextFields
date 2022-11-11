//
//  InputLimitViewController.swift
//  Text Fields
//
//  Created by Антон Заверуха on 20.06.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import UIKit

protocol InputLengthValidatorDelegate: AnyObject {
    func lengthCount(newLength: Int)
}

protocol InputLengthValidatorLabelColorDelegate: AnyObject {
    func colorLabelChange(newLength: Int)
}

protocol InputLengthValidatorTextFieldDelegate: AnyObject {
    func textFieldColorAndBorderCheck(newLength: Int)
}

class InputLengthViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var inputLimitTextField: UITextField!
    @IBOutlet weak var lengthCounterLabel: UILabel!
    var secondProcess = InputLengthValidator()
    let expectedLength = 10
    override func viewDidLoad() {
        super.viewDidLoad()
        secondProcess.inputLengthValidatorTextFieldDelegate = self
        secondProcess.inputLengthValidatorLabelColorDelegate = self
        secondProcess.inputLengthValidatorDelegate = self
        inputLimitTextField.delegate = self
        inputLimitTextField.backgroundColor = UIColor(red: 0.46, green: 0.46, blue: 0.5, alpha: 0.12)
        inputLimitTextField.layer.cornerRadius = 4
        lengthCounterLabel.text = "\(expectedLength)/\(expectedLength)"
    }
}

extension InputLengthViewController: InputLengthValidatorDelegate, InputLengthValidatorLabelColorDelegate, InputLengthValidatorTextFieldDelegate {
    
    func textFieldColorAndBorderCheck(newLength: Int) {
        if newLength > 10 {
        inputLimitTextField.layer.borderWidth = 1
        inputLimitTextField.layer.borderColor = UIColor.red.cgColor
        } else {
        inputLimitTextField.layer.borderWidth = 0
        inputLimitTextField.layer.borderColor = UIColor.black.cgColor
        }
    }
        
    func lengthCount(newLength: Int) {
        lengthCounterLabel.text = "\(expectedLength - newLength)/\(expectedLength)"
    }
    
    func colorLabelChange(newLength: Int) {
        if newLength > expectedLength {
            lengthCounterLabel.textColor = UIColor.red
        } else {
            lengthCounterLabel.textColor = UIColor.black
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return secondProcess.processSecondTextField(text: textField.text, shouldChangeCharactersIn: range, replacementString: string)
    }
}
