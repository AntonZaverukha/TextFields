//
//  LinkRecognize.swift
//  Text Fields
//
//  Created by Антон Заверуха on 20.06.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

struct LinkValidator {
    weak var linkValidatorDelegate : LinkValidatorDelegate?
    
    func processFourthTextField(text: String?, replacementString string: String) -> Bool {
        if let paste = UIPasteboard.general.string, string == paste {
            self.linkValidatorDelegate?.sfSafariOpen(urlString: string)
        }
        return true
    }
}
