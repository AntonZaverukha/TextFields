//
//  InputLimit.swift
//  Text Fields
//
//  Created by Антон Заверуха on 20.06.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import Foundation
import UIKit

struct InputLengthValidator {
    weak var inputLengthValidatorDelegate: InputLengthValidatorDelegate?
    weak var inputLengthValidatorLabelColorDelegate: InputLengthValidatorLabelColorDelegate?
    weak var inputLengthValidatorTextFieldDelegate: InputLengthValidatorTextFieldDelegate?
    
    func processSecondTextField (text: String?, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let unwrappedTextFieldTextCount = text?.count {
            let newLength = unwrappedTextFieldTextCount + string.count - range.length
            self.inputLengthValidatorDelegate?.lengthCount(newLength: newLength)
            self.inputLengthValidatorTextFieldDelegate?.textFieldColorAndBorderCheck(newLength: newLength)
            self.inputLengthValidatorLabelColorDelegate?.colorLabelChange(newLength: newLength)
        }
        return true
    }
}
