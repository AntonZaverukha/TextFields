//
//  NoDigit.swift
//  Text Fields
//
//  Created by Антон Заверуха on 20.06.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import Foundation
import UIKit

struct NoDigitsValidator {
    func processFirstTextField(text: String?, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let paste = UIPasteboard.general.string, string == paste, var unwrappedTextFieldText = text {
            let finalText = unwrappedTextFieldText + string
            if (finalText.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil) {
                let finalTextWithoutDigits = (finalText.components(separatedBy: CharacterSet.decimalDigits)).joined(separator: "")
                unwrappedTextFieldText = finalTextWithoutDigits
                return false
            } else {
                return true
            }
        } else {
            if string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil  {
                return false
            } else {
                return true
            }
        }
    }
}
