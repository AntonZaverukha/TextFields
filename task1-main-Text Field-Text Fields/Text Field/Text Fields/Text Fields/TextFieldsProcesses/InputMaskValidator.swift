//
//  InputMask.swift
//  Text Fields
//
//  Created by Антон Заверуха on 20.06.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import Foundation
import UIKit

struct InputMaskValidator {
    weak var inputMaskValidatorTextFieldAddHyphenDelegate: InputMaskValidatorTextFieldAddHyphenDelegate?
    weak var inputMaskValidatorTextFieldRemoveHyphenDelegate: InputMaskValidatorTextFieldRemoveHyphenDelegate?
    
    func processThirdTextField(text: String?, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let unwrappedTextFieldTextCount = text?.count, let unwrappedTextFieldText = text {
            guard string != "" else {
                if unwrappedTextFieldTextCount == 7 {
                    self.inputMaskValidatorTextFieldRemoveHyphenDelegate?.removeHyphen()
                    return false
                }
                return true
            }
            switch unwrappedTextFieldTextCount {
            case 0...4:
                if (string.rangeOfCharacter(from: NSCharacterSet.letters) != nil) {
                    if unwrappedTextFieldTextCount + 1 == 5 {
                        self.inputMaskValidatorTextFieldAddHyphenDelegate?.addHyphen(string: string, text: unwrappedTextFieldText)
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
}
