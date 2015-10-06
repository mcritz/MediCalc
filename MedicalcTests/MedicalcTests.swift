//
//  MedicalcTests.swift
//  MedicalcTests
//
//  Created by Critz, Michael on 10/5/15.
//  Copyright © 2015 Map of the Unexplored. All rights reserved.
//

import XCTest
@testable import Medicalc

class MedicalcTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDoubleFromString() {
        let doseMan = Dose()
        
        var rd = doseMan.doubleFromString("Hello")
        XCTAssertEqual(rd, 0)
		
		rd = doseMan.doubleFromString(nil)
		XCTAssert(rd == 0, "should return 0 if nil")
        
        rd = doseMan.doubleFromString("1.0")
        XCTAssertEqual(rd, Double(1))
        
        rd = doseMan.doubleFromString("6.66666")
        XCTAssertEqual(rd, Double(6.66666))
    }
    
    func testFormatDose() {
        let doseMan = Dose()
        
        var rd :String = doseMan.formatDose(5)
        XCTAssertEqual(rd, "5")
		
		rd = doseMan.formatDose(nil)
		XCTAssert(rd == "—", "Should return — if NaN")
    }
	
	func testUpdateResult() {
		let doseMan = Dose()
		
		var rd :String = doseMan.updateResult(nil, weight: "10")
		XCTAssert(rd == "—", "should return — when dose is nil")
		
		rd = doseMan.updateResult("10", weight: nil)
		XCTAssert(rd == "—", "should return — when weight is nil")
	}
    
}
