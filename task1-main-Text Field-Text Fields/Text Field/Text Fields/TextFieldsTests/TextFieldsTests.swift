//
//  TextFieldsTests.swift
//  TextFieldsTests
//
//  Created by Антон Заверуха on 19.06.2022.
//  Copyright © 2022 Антон Заверуха. All rights reserved.
//

import XCTest
import UIKit
@testable import Text_Fields

class TextFieldsTests: XCTestCase {
    var noDigits: NoDigitsValidator!
    var inputLength: InputLengthValidator!
    var inputMask: InputMaskValidator!
    var linkRecognize: LinkValidator!
    var passwordValidation: PasswordValidator!
    
    override func setUpWithError() throws {
        noDigits = NoDigitsValidator()
        inputLength = InputLengthValidator()
        inputMask = InputMaskValidator()
        linkRecognize = LinkValidator()
        passwordValidation = PasswordValidator()
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        noDigits = nil
        inputLength = nil
        inputMask = nil
        linkRecognize = nil
        passwordValidation = nil
        try super.tearDownWithError()
    }
    
    func testDigitsInput() throws {
        let noDigitString = ""
        let nsString = noDigitString as NSString
        let textRange = NSMakeRange(0, nsString.length)
        let result = noDigits.processFirstTextField(text: noDigitString, shouldChangeCharactersIn: textRange, replacementString: "Test1")
        XCTAssertFalse(result)
    }
    
    func testNoDigitsInput() throws {
        let noDigitString = ""
        let nsString = noDigitString as NSString
        let textRange = NSMakeRange(0, nsString.length)
        let result = noDigits.processFirstTextField(text: noDigitString, shouldChangeCharactersIn: textRange, replacementString: "Test stri ng !")
        XCTAssertTrue(result)
    }
    
    func testPasteWithoutDigits() throws {
        let pasteString = "test"
        UIPasteboard.general.string = pasteString
        let result = noDigits.processFirstTextField(text: UIPasteboard.general.string, shouldChangeCharactersIn: NSMakeRange(0, pasteString.count), replacementString: UIPasteboard.general.string!)
        XCTAssertTrue(result)
    }
    
    func testPasteWithDigits() throws {
           let pasteString = "test1"
           UIPasteboard.general.string = pasteString
           let result = noDigits.processFirstTextField(text: UIPasteboard.general.string, shouldChangeCharactersIn: NSMakeRange(0, pasteString.count), replacementString: UIPasteboard.general.string!)
           XCTAssertFalse(result)
       }
    
    func testMaskInput() throws {
        let inputString = "wwwww12345"
        let nsString = inputString as NSString
        let textRange = NSMakeRange(0, nsString.length)
        let result = inputMask.processThirdTextField(text: inputString, shouldChangeCharactersIn: textRange, replacementString: inputString)
        XCTAssertTrue(result)
    }
    
    func testMaskInputLetters() throws {
        let inputString = "www"
        let nsString = inputString as NSString
        let textRange = NSMakeRange(0, nsString.length)
        let result = inputMask.processThirdTextField(text: inputString, shouldChangeCharactersIn: textRange, replacementString: inputString)
        XCTAssertTrue(result)
    }
    
    func testMaskInputLettersIncorrect() throws {
        let inputString = "w21w"
        let nsString = inputString as NSString
        let textRange = NSMakeRange(0, nsString.length)
        let result = inputMask.processThirdTextField(text: inputString, shouldChangeCharactersIn: textRange, replacementString: inputString)
        XCTAssertFalse(result)
    }
    
    func testMaskInputRangeIncorrect() throws {
        let inputString = "wwwww123456"
        let nsString = inputString as NSString
        let textRange = NSMakeRange(0, nsString.length)
        let result = inputMask.processThirdTextField(text: inputString, shouldChangeCharactersIn: textRange, replacementString: inputString)
        XCTAssertFalse(result)
    }
    
    func testMaskInputAddHyphen() throws {
        let inputString = "wwwww"
        let nsString = inputString as NSString
        let textRange = NSMakeRange(0, nsString.length)
        let result = inputMask.processThirdTextField(text: inputString, shouldChangeCharactersIn: textRange, replacementString: inputString)
        XCTAssertFalse(result)
    }
    
    func testMaskInputDigit() throws {
        let inputString = "wwwww1"
        let nsString = inputString as NSString
        let textRange = NSMakeRange(0, nsString.length)
        let result = inputMask.processThirdTextField(text: inputString, shouldChangeCharactersIn: textRange, replacementString: inputString)
        XCTAssertTrue(result)
    }
    
    func testLinkRecognizeIncorrect() throws {
        let inputString = "htt:/fakeUrl.com"
        let result = String.isValidUrl(url: inputString)
        XCTAssertFalse(result)
    }
    
    func testLinkRecognizeCorrect() throws {
        let inputString = "http://notfakeurl.com"
        let result = String.isValidUrl(url: inputString)
        XCTAssertTrue(result)
    }
    
    func testDigitsCorrect() throws {
        let inputString = "T1e2s3t4"
        let result = String.isValidDigits(password: inputString)
        XCTAssertTrue(result)
    }
    
    func testDigitsIncorrect() throws {
        let inputString = "Test"
        let result = String.isValidDigits(password: inputString)
        XCTAssertFalse(result)
    }
    
    func testLengthIncorrect() throws {
        let inputString = "t1/stst"
        let result = String.isValidLength(password: inputString)
        XCTAssertFalse(result)
    }
    
    func testLengthCorrect() throws {
        let inputString = "Teststring"
        let result = String.isValidLength(password: inputString)
        XCTAssertTrue(result)
    }
    
    func testLowerCaseCorrect() throws {
        let inputString = "t1/stst"
        let result = String.isValidLowerCase(password: inputString)
        XCTAssertTrue(result)
    }
    
    func testLowerCaseIncorrect() throws {
        let inputString = "TEST ! @STRIN G"
        let result = String.isValidLowerCase(password: inputString)
        XCTAssertFalse(result)
    }
    
    func testCapitalLettersInCorrect() throws {
        let inputString = "test string/."
        let result = String.isValidCapital(password: inputString)
        XCTAssertFalse(result)
    }
    
    func testCapitalLettersCorrect() throws {
        let inputString = "testString"
        let result = String.isValidCapital(password: inputString)
        XCTAssertTrue(result)
    }
}
