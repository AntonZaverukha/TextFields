//
//  Text_FieldsUITests.swift
//  Text FieldsUITests
//
//  Created by Антон Заверуха on 24.06.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import XCTest

class Text_FieldsUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testNoDigitInput() throws {
        let app = XCUIApplication()
        let noDigitsTF = app.textFields["NoDigitTF"]
        app.launch()
        
        noDigitsTF.tap()
        noDigitsTF.typeText("12Test1 string12")
        XCTAssertEqual(app.textFields["NoDigitTF"].value as! String, "Test string")
    }
    
    func testInputLength() throws {
        let app = XCUIApplication()
        let inputLimitTF = app.textFields["InputLimitTF"]
        app.launch()
        
        inputLimitTF.tap()
        inputLimitTF.typeText("12345678901")
        XCTAssertEqual("-1/10", app.staticTexts.element(matching: .any, identifier: "InputLengthLabel").label)
    }
    
    func testMaskInput() throws {
        let app = XCUIApplication()
        let inputMaskTF = app.textFields["InputMaskTF"]
        app.launch()
        
        inputMaskTF.tap()
        inputMaskTF.typeText("wwwww12345")
        XCTAssertEqual(app.textFields["InputMaskTF"].value as! String, "wwwww-12345")
    }
    
    func testPasswordValidation() throws {
        let app = XCUIApplication()
        let passwordTF = app.textFields["PasswordTF"]
        let progressView = app.progressIndicators["PasswordProgressView"]
        app.launch()
      
        passwordTF.tap()
        passwordTF.typeText("T")
        XCTAssertEqual(app.staticTexts["PasswordCapitalLabel"].label, "✓ Min 1 capital required.")
        let currentValueFirst = progressView.value as? String
        XCTAssertEqual(currentValueFirst, "25%")
        
        passwordTF.typeText("e")
        XCTAssertEqual(app.staticTexts["PasswordLowerCaseLabel"].label, "✓ Min 1 lowercase.")
        let currentValueSecond = progressView.value as? String
        XCTAssertEqual(currentValueSecond, "50%")
        
        passwordTF.typeText("1")
        XCTAssertEqual(app.staticTexts["PasswordDigitsLabel"].label, "✓ Min 1 digit.")
        let currentValueThird = progressView.value as? String
        XCTAssertEqual(currentValueThird, "75%")
        
        passwordTF.typeText("String8")
        XCTAssertEqual(app.staticTexts["PasswordLengthLabel"].label, "✓ Min length 8 characters.")
        let currentValueFourth = progressView.value as? String
        XCTAssertEqual(currentValueFourth, "100%")
        
    }
}
