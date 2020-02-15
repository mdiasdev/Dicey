//
//  RollerTests.swift
//  DiceyTests
//
//  Created by Matthew Dias on 12/7/19.
//  Copyright © 2019 Matthew Dias. All rights reserved.
//

import XCTest

@testable import Dicey

class RollerTests: XCTestCase {
    var sut: RollerViewController!
    
    override func setUp() {
        super.setUp()
        
        sut = RollerViewController()
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }

    func test_rollingOneDie_isWithinNumberOfDieSides() {
        let result = sut.roll(1, .d20)
        
        XCTAssertLessThan(result, 21, "d20 can only be 1-20")
        XCTAssertGreaterThan(result, 0, "d20 can only be 1-20")
    }
    
//    func test_selectingDie_deselectsPreviouslySelectedDie() {
//        let button1 = UIButton()
//        button1.isSelected = true
//        let button2 = UIButton()
//        sut.dice = [button1, button2]
//
//        sut.setSelected(button2)
//
//        XCTAssertTrue(button2.isSelected)
//        XCTAssertFalse(button1.isSelected)
//    }
//
//    func test_minusButton_cannotSetDiceNumber_lessThanOne() {
//        let minus = UIButton()
//        let textField = UITextField()
//        sut.minusButton = minus
//        sut.diceNumberTextField = textField
//        sut.diceNumber = 2
//
//        sut.minusTapped(minus)
//
//        XCTAssertEqual(sut.diceNumber, 1)
//
//        sut.minusTapped(minus)
//
//        XCTAssertEqual(sut.diceNumber, 1)
//    }
//
//    func test_plusButton_cannotSetDiceNumber_greaterThanOneHundred() {
//        let plus = UIButton()
//        let textField = UITextField()
//        sut.plusButton = plus
//        sut.diceNumberTextField = textField
//        sut.diceNumber = 99
//
//        sut.plusTapped(plus)
//
//        XCTAssertEqual(100, sut.diceNumber, "max number of dice allowed to be rolled is 100")
//
//        sut.plusTapped(plus)
//
//        XCTAssertEqual(100, sut.diceNumber, "max number of dice allowed to be rolled is 100")
//    }
    
    func test_diceToRollString_emptyString() {
        let expectedString = "1d4"
        
        let actualString = sut.diceToRollString(from: "", die: .d4, count: 1)
        
        XCTAssertEqual(expectedString, actualString)
    }
    
    func test_diceToRollString_appendingString() {
        let expectedString = "1d6, 1d4"
        
        let actualString = sut.diceToRollString(from: "1d6", die: .d4, count: 1)
        
        XCTAssertEqual(expectedString, actualString)
    }
    
    func test_diceToRollString_replacingString() {
        let expectedString = "1d6, 2d4"
        
        let actualString = sut.diceToRollString(from: "1d6, 1d4", die: .d4, count: 2)
        
        XCTAssertEqual(expectedString, actualString)
    }

}
