//
//  PasswordValidationViewController.swift
//  Text Fields
//
//  Created by Антон Заверуха on 20.06.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import UIKit

protocol PasswordValidatorLabelDelegate : AnyObject {
    func didValidateLabel(isValidLength: Bool, isValidDigits: Bool, isValidLowerCase: Bool, isValidCapital: Bool)
}

protocol PasswordValidatorProgressViewAddDelegate: AnyObject {
    func addProgress()
}

protocol PasswordValidatorProgressViewRemoveDelegate: AnyObject {
    func removeProgress()
}

protocol PasswordValidatorProgressViewColorDelegate: AnyObject {
    func checkProgressViewColor()
}

class PasswordValidationViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var minLengthLabel: UILabel!
    @IBOutlet weak var minDigitsLabel: UILabel!
    @IBOutlet weak var minLowerCaseLabel: UILabel!
    @IBOutlet weak var minCapitalLettersLabel: UILabel!
    @IBOutlet weak var passwordValidationProgressView: UIProgressView!
    @IBOutlet weak var passwordValidationTextField: UITextField!
    var fifthProcess = PasswordValidator()
    override func viewDidLoad() {
        fifthProcess.progressDelegate = self
        fifthProcess.labelDelegate = self
        fifthProcess.progressRemoveDelegate = self
        fifthProcess.progressColorDelegate = self
        super.viewDidLoad()
        passwordValidationTextField.delegate = self
        passwordValidationTextField.backgroundColor = UIColor(red: 0.46, green: 0.46, blue: 0.5, alpha: 0.12)
        passwordValidationTextField.layer.cornerRadius = 4
        passwordValidationProgressView.isHidden = false
        passwordValidationProgressView.setProgress(0.0, animated: false)
    }
}

extension PasswordValidationViewController: PasswordValidatorLabelDelegate, PasswordValidatorProgressViewAddDelegate, PasswordValidatorProgressViewRemoveDelegate, PasswordValidatorProgressViewColorDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return fifthProcess.processFifthTextField(text: textField.text, shouldChangeCharactersIn: range, replacementString: string)
    }
    
    func minDigitsCorrect() {
        minDigitsLabel.textColor = UIColor.green
        minDigitsLabel.text = "✓ Min 1 digit."
    }
    
    func minDigitsIncorrect() {
        minDigitsLabel.textColor = UIColor.black
        minDigitsLabel.text = "- Min 1 digit."
    }
    
    func minLengthCorrect() {
        minLengthLabel.textColor = UIColor.green
        minLengthLabel.text = "✓ Min length 8 characters."
    }
    
    func minLengthIncorrect() {
        minLengthLabel.textColor = UIColor.black
        minLengthLabel.text = "- Min length 8 characters."
    }
    
    func minLowerCaseCorrect() {
        minLowerCaseLabel.textColor = UIColor.green
        minLowerCaseLabel.text = "✓ Min 1 lowercase."
    }
    
    func minLowerCaseIncorrect() {
        minLowerCaseLabel.textColor = UIColor.black
        minLowerCaseLabel.text = "- Min 1 lowercase."
    }
    
    func minCapitalLettersCorrect() {
        minCapitalLettersLabel.textColor = UIColor.green
        minCapitalLettersLabel.text = "✓ Min 1 capital required."
    }
    
    func minCapitalLettersIncorrect() {
        minCapitalLettersLabel.textColor = UIColor.black
        minCapitalLettersLabel.text = "- Min 1 capital required."
    }
    
    func didValidateLabel(isValidLength: Bool, isValidDigits: Bool, isValidLowerCase: Bool, isValidCapital: Bool) {
        minLengthCorrect()
        if !isValidLength {
            minLengthIncorrect()
        }
        minCapitalLettersCorrect()
        if !isValidCapital {
           minCapitalLettersIncorrect()
        }
        minLowerCaseCorrect()
        if !isValidLowerCase {
            minLowerCaseIncorrect()
        }
        minDigitsCorrect()
        if !isValidDigits {
           minDigitsIncorrect()
        }
    }
    
    func removeProgress() {
        let progress = passwordValidationProgressView.progress
        passwordValidationProgressView.setProgress(progress - 0.25, animated: false)
    }
    
    func addProgress() {
        let progress = passwordValidationProgressView.progress
        passwordValidationProgressView.setProgress(progress + 0.25, animated: false)
    }
    
    func checkProgressViewColor() {
        if passwordValidationProgressView.progress == 0.25 {
            passwordValidationProgressView.tintColor = UIColor.red
        }
        if passwordValidationProgressView.progress == 0.5 {
            passwordValidationProgressView.tintColor = UIColor.orange
        }
        if passwordValidationProgressView.progress == 0.75 {
            passwordValidationProgressView.tintColor = UIColor.orange
        }
        if passwordValidationProgressView.progress == 1.0 {
            passwordValidationProgressView.tintColor = UIColor.green
        }
    }
}
