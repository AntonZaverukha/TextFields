//
//  ExtensionString.swift
//  Text Fields
//
//  Created by Антон Заверуха on 14.06.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import Foundation

public extension String {
    
    static func isValidUrl(url: String) -> Bool {
        let urlRegEx = "^(https?://)?(http?://)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
        let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
        let result = urlTest.evaluate(with: url)
        return result
    }
    
    static func isValidLetters(password: String) -> Bool {
        let passwordRegex = "[a-zA-Z]{0,5}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        let result = passwordTest.evaluate(with: password)
        return result
    }
    
    static func isValidMask(password: String) -> Bool {
        let passwordRegex = "([a-zA-Z]{0,5}[^A-Za-z0-9][0-9]{0,5})$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        let result = passwordTest.evaluate(with: password)
        return result
    }
    
    static func isValidPass(password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        let result = passwordTest.evaluate(with: password)
        return result
    }
    
    static func isValidLength(password: String) -> Bool {
        let passwordRegex = "^.{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        let result = passwordTest.evaluate(with: password)
        return result
    }
    
    static func isValidDigits(password: String) -> Bool {
        let passwordRegex = ".*\\d.*"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        let result = passwordTest.evaluate(with: password)
        return result
    }
    
    static func isValidLowerCase(password: String) -> Bool {
        let passwordRegex = ".*[a-z].*"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        let result = passwordTest.evaluate(with: password)
        return result
    }
    
    static func isValidCapital(password: String) -> Bool {
        let passwordRegex = ".*[A-Z].*"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        let result = passwordTest.evaluate(with: password)
        return result
    }
}
