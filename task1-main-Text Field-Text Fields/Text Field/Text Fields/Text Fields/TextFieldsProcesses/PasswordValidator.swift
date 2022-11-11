//
//  PasswordValidation.swift
//  Text Fields
//
//  Created by Антон Заверуха on 20.06.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import Foundation
import UIKit

struct PasswordValidator {
    weak var labelDelegate : PasswordValidatorLabelDelegate?
    weak var progressDelegate : PasswordValidatorProgressViewAddDelegate?
    weak var progressRemoveDelegate : PasswordValidatorProgressViewRemoveDelegate?
    weak var progressColorDelegate : PasswordValidatorProgressViewColorDelegate?
    
    var hasValidLength: Bool = false {
        didSet {
            self.labelDelegate?.didValidateLabel(isValidLength: hasValidLength, isValidDigits: containsValidDigits, isValidLowerCase: containsValidLowerCaseLetters, isValidCapital: containsValidCapitalLetters)
            if hasValidLength == true {
                if hasValidLength != oldValue {
                    self.progressDelegate?.addProgress()
                    self.progressColorDelegate?.checkProgressViewColor()
                }
            } else if hasValidLength == false {
                if hasValidLength != oldValue {
                    self.progressRemoveDelegate?.removeProgress()
                    self.progressColorDelegate?.checkProgressViewColor()
                }
            }
        }
    }
    var containsValidDigits: Bool = false {
        didSet {
            self.labelDelegate?.didValidateLabel(isValidLength: hasValidLength, isValidDigits: containsValidDigits, isValidLowerCase: containsValidLowerCaseLetters, isValidCapital: containsValidCapitalLetters)
            if containsValidDigits == true {
                if containsValidDigits != oldValue {
                    self.progressDelegate?.addProgress()
                    self.progressColorDelegate?.checkProgressViewColor()
                }
            } else if containsValidDigits == false {
                if containsValidDigits != oldValue {
                    self.progressRemoveDelegate?.removeProgress()
                    self.progressColorDelegate?.checkProgressViewColor()
                }
            }
        }
    }
    var containsValidLowerCaseLetters: Bool = false {
        didSet {
            if containsValidLowerCaseLetters == true {
                self.labelDelegate?.didValidateLabel(isValidLength: hasValidLength, isValidDigits: containsValidDigits, isValidLowerCase: containsValidLowerCaseLetters, isValidCapital: containsValidCapitalLetters)
                if containsValidLowerCaseLetters != oldValue {
                    self.progressDelegate?.addProgress()
                    self.progressColorDelegate?.checkProgressViewColor()
                }
            } else if containsValidLowerCaseLetters == false {
                if containsValidLowerCaseLetters != oldValue {
                    self.progressRemoveDelegate?.removeProgress()
                    self.progressColorDelegate?.checkProgressViewColor()
                }
            }
        }
    }
    var containsValidCapitalLetters: Bool = false {
        didSet {
            self.labelDelegate?.didValidateLabel(isValidLength: hasValidLength, isValidDigits: containsValidDigits, isValidLowerCase: containsValidLowerCaseLetters, isValidCapital: containsValidCapitalLetters)
            if containsValidCapitalLetters == true {
                if containsValidCapitalLetters != oldValue {
                    self.progressDelegate?.addProgress()
                    self.progressColorDelegate?.checkProgressViewColor()
                }
            } else if containsValidCapitalLetters == false {
                if containsValidCapitalLetters != oldValue {
                    self.progressRemoveDelegate?.removeProgress()
                    self.progressColorDelegate?.checkProgressViewColor()
                }
            }
        }
    }
    mutating func processFifthTextField(text: String?, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let unwrappedTextFieldText = text,
            let textRange = Range(range, in: unwrappedTextFieldText) {
            let updatedText = unwrappedTextFieldText.replacingCharacters(in: textRange,
                                                       with: string)
            if (range.length > 0)
            {
                    containsValidDigits = String.isValidDigits(password: updatedText)
                    hasValidLength = String.isValidLength(password: updatedText)
                    containsValidLowerCaseLetters = String.isValidLowerCase(password: updatedText)
                    containsValidCapitalLetters = String.isValidCapital(password: updatedText)
            }
            else
            {
                    containsValidDigits = String.isValidDigits(password: updatedText)
                    hasValidLength = String.isValidLength(password: updatedText)
                    containsValidLowerCaseLetters = String.isValidLowerCase(password: updatedText)
                    containsValidCapitalLetters = String.isValidCapital(password: updatedText)
            }
        }
        return true
    }
}
