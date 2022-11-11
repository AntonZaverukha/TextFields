//
//  ViewController.swift
//  Text Fields
//
//  Created by Антон Заверуха on 09.06.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UITextFieldDelegate, SFSafariViewControllerDelegate {
    
    var hasValidLength: Bool = false {
        didSet {
            if hasValidLength == true {
                minLengthCorrect()
                if hasValidLength != oldValue {
                    addProgress()
                    progressColorCheck()
                }
            } else if hasValidLength == false {
                minLengthIncorrect()
                if hasValidLength != oldValue {
                    removeProgress()
                    progressColorCheck()
                }
            }
        }
    }
    var containsValidDigits: Bool = false {
        didSet {
            if containsValidDigits == true {
                minDigitsCorrect()
                if containsValidDigits != oldValue {
                    addProgress()
                    progressColorCheck()
                }
            } else if containsValidDigits == false {
                minDigitsIncorrect()
                if containsValidDigits != oldValue {
                    removeProgress()
                    progressColorCheck()
                }
            }
        }
    }
    var containsValidLowerCaseLetters: Bool = false {
        didSet {
            if containsValidLowerCaseLetters == true {
                minLowerCaseCorrect()
                if containsValidLowerCaseLetters != oldValue {
                    addProgress()
                    progressColorCheck()
                }
            } else if containsValidLowerCaseLetters == false {
                minLowerCaseIncorrect()
                if containsValidLowerCaseLetters != oldValue {
                    removeProgress()
                    progressColorCheck()
                }
            }
        }
    }
    var containsValidCapitalLetters: Bool = false {
        didSet {
            if containsValidCapitalLetters == true {
                minCapitalLettersCorrect()
                if containsValidCapitalLetters != oldValue {
                    addProgress()
                    progressColorCheck()
                }
            } else if containsValidCapitalLetters == false {
                minCapitalLettersIncorrect()
                if containsValidCapitalLetters != oldValue {
                    removeProgress()
                    progressColorCheck()
                }
            }
        }
    }
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var thirdTextField: UITextField!
    @IBOutlet weak var fourthTextField: UITextField!
    @IBOutlet weak var fifthTextField: UITextField!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var minLengthLabel: UILabel!
    @IBOutlet weak var minLowerCaseLabel: UILabel!
    @IBOutlet weak var minDigitsLabel: UILabel!
    @IBOutlet weak var minCapitalLettersLabel: UILabel!    
    @IBOutlet weak var passwordStrengthProgressView: UIProgressView!
    @IBOutlet weak var tabBarButton: UIButton!
    
    let expectedLength = 10
    override func viewDidLoad() {
        super.viewDidLoad()
        firstTextField.backgroundColor = UIColor(red: 0.46, green: 0.46, blue: 0.5, alpha: 0.12)
        secondTextField.backgroundColor = UIColor(red: 0.46, green: 0.46, blue: 0.5, alpha: 0.12)
        thirdTextField.backgroundColor = UIColor(red: 0.46, green: 0.46, blue: 0.5, alpha: 0.12)
        fourthTextField.backgroundColor = UIColor(red: 0.46, green: 0.46, blue: 0.5, alpha: 0.12)
        fifthTextField.backgroundColor = UIColor(red: 0.46, green: 0.46, blue: 0.5, alpha: 0.12)
        firstTextField.layer.cornerRadius = 4
        secondTextField.layer.cornerRadius = 4
        thirdTextField.layer.cornerRadius = 4
        fourthTextField.layer.cornerRadius = 4
        fifthTextField.layer.cornerRadius = 4
        firstTextField.delegate = self
        secondTextField.delegate = self
        thirdTextField.delegate = self
        fourthTextField.delegate = self
        fifthTextField.delegate = self
        counterLabel.text = "\(expectedLength)/\(expectedLength)"
        passwordStrengthProgressView.isHidden = false
        passwordStrengthProgressView.setProgress(0.0, animated: false)
        tabBarButton.layer.cornerRadius = 4
    }
}

extension ViewController {
    
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
    
    func removeProgress() {
        let progress = passwordStrengthProgressView.progress
        passwordStrengthProgressView.setProgress(progress - 0.25, animated: false)
    }
    
    func addProgress() {
        let progress = passwordStrengthProgressView.progress
        passwordStrengthProgressView.setProgress(progress + 0.25, animated: false)
    }
    
    func progressColorCheck(){
        if passwordStrengthProgressView.progress == 0.25 {
            passwordStrengthProgressView.tintColor = UIColor.red
        }
        if passwordStrengthProgressView.progress == 0.5 {
            passwordStrengthProgressView.tintColor = UIColor.orange
        }
        if passwordStrengthProgressView.progress == 0.75 {
            passwordStrengthProgressView.tintColor = UIColor.orange
        }
        if passwordStrengthProgressView.progress == 1.0 {
            passwordStrengthProgressView.tintColor = UIColor.green
        }
    }
    
    func sfSafariOpen(urlString: String){
        if String.isValidUrl(url: urlString){
            var url: URL?
                url = URL(string: urlString)
            if let url = url {
                let sfViewController = SFSafariViewController(url: url)
                self.present(sfViewController, animated: true, completion: nil)
            }
        }
    }
    
    func processFirstTextField(textfield: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let paste = UIPasteboard.general.string, string == paste, let unwrappedTextFieldText = textfield.text {
            let finalText = unwrappedTextFieldText + string
            if (finalText.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil) {
                let finalTextWithoutDigits = (finalText.components(separatedBy: CharacterSet.decimalDigits)).joined(separator: "")
                textfield.text = finalTextWithoutDigits
                return false
            } else {
                return true
            }
        } else {
            if string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil  {
                return false
            } else {
                textfield.isUserInteractionEnabled = true
                return true
            }
        }
    }
    
    func processSecondTextField(textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let unwrappedTextFieldTextCount = textField.text?.count {
            let newLength = unwrappedTextFieldTextCount + string.count - range.length
            counterLabel.text = "\(expectedLength - newLength)/\(expectedLength)"
            if newLength > expectedLength {
                counterLabel.textColor = UIColor.red
                textField.layer.borderWidth = 1
                textField.layer.borderColor = UIColor.red.cgColor
            } else {
                counterLabel.textColor = UIColor.black
                textField.layer.borderWidth = 0
                textField.layer.borderColor = UIColor.black.cgColor
            }
        }
        return true
    }
    
    func processThirdTextField(textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let unwrappedTextFieldTextCount = textField.text?.count, var unwrappedTextFieldText = textField.text {
            guard string != "" else {
                if unwrappedTextFieldTextCount == 7 {
                    unwrappedTextFieldText.removeLast(2)
                    textField.text = unwrappedTextFieldText
                    return false
                }
                return true
            }
            switch unwrappedTextFieldTextCount {
            case 0...4:
                if (string.rangeOfCharacter(from: NSCharacterSet.letters) != nil) {
                    if unwrappedTextFieldTextCount + 1 == 5 {
                        textField.text = unwrappedTextFieldText + string + "-"
                        return false
                    }
                    return true
                } else {
                    return false
                }
            case 6...10:
                if (string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil) {
                    return true
                } else {
                    return false
                }
            default:
                break
            }
        }
        return false
    }
    
    func processFourthTextField(textField: UITextField, replacementString string: String) -> Bool {
        if let paste = UIPasteboard.general.string, string == paste {
            sfSafariOpen(urlString: string)
        }
        return true
    }
    
    func processFifthTextField(textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            if (range.length > 0)
            {
                if textField.text != nil {
                    containsValidDigits = String.isValidDigits(password: updatedText)
                    hasValidLength = String.isValidLength(password: updatedText)
                    containsValidLowerCaseLetters = String.isValidLowerCase(password: updatedText)
                    containsValidCapitalLetters = String.isValidCapital(password: updatedText)
                }
            }
            else
            {
                if textField.text != nil {
                    containsValidDigits = String.isValidDigits(password: updatedText)
                    hasValidLength = String.isValidLength(password: updatedText)
                    containsValidLowerCaseLetters = String.isValidLowerCase(password: updatedText)
                    containsValidCapitalLetters = String.isValidCapital(password: updatedText)
                }
            }
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == firstTextField {
            return processFirstTextField(textfield: textField, shouldChangeCharactersIn: range, replacementString: string)
        } else if textField == secondTextField {
            return processSecondTextField(textField: textField, shouldChangeCharactersIn: range, replacementString: string)
        } else if textField == thirdTextField {
            return processThirdTextField(textField: textField, shouldChangeCharactersIn: range, replacementString: string)
        } else if textField == fourthTextField {
            return processFourthTextField(textField: textField, replacementString: string)
        } else if textField == fifthTextField {
            return processFifthTextField(textField: textField, shouldChangeCharactersIn: range, replacementString: string)
        }
        return true
    }
}





