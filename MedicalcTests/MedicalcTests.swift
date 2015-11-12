//
//  MedicalcTests.swift
//  MedicalcTests
//
//  Created by Critz, Michael on 10/5/15.
//  Copyright © 2015 Map of the Unexplored. All rights reserved.
//

import XCTest
//@testable import Medicalc

class MedicalcTests: XCTestCase {
	let types = [DoseType.Empty,
		DoseType.AdultKilgrams,
		DoseType.MedicinceConcentrationNanogramsPerMilliliter,
		DoseType.Rate]
    
    var doseMan = Dose()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        doseMan = Dose()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	func testDefaultDesc() {
		for someType in types {
			let rd = someType.desc()
			XCTAssertTrue(rd.dynamicType == String.self)
		}
	}
	
	func testDataValues() {
		
		for someType in types {
			let rd = doseMan.dataValues(someType)
			XCTAssertTrue(rd.dynamicType == [Double].self)
		}
	}
	
	func testCalculate() {
		var rd = doseMan.calculate([0])
		XCTAssert(rd.dynamicType == Double.self, "Calculate returns a double")
		rd = doseMan.calculate([1])
		XCTAssert(rd == Double(0), "Calculate returns 0 for 1")
	}
    
    func testDoubleFromString() {
        
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
        
        var rd :String = doseMan.formatDose(5)
        XCTAssertEqual(rd, "5")
		
		rd = doseMan.formatDose(nil)
		XCTAssert(rd == DoseType.Empty.desc(), "Should return — if nil")
		
		rd = doseMan.formatDose(Double.infinity)
        XCTAssertEqual(rd, DoseType.Empty.desc(), "Should return — if nonnormal number")
    }
	
	func testUpdateResult() {
		var rd :String = doseMan.updateResult([nil,"50"])
		XCTAssert(rd == DoseType.Empty.desc(), "should return — when input is nil")
		
		rd = doseMan.updateResult(["10.4", ""])
		XCTAssert(rd == DoseType.Empty.desc(), "should return — when input is empty")
        
        rd = doseMan.updateResult(["10.0", "20.0", "30"])
        XCTAssertTrue(rd != "", "There should be some non-empty string result")
	}
	
	func testFlolanCalculate() {
		let flolan = Flolan()
		
		let rd = flolan.calculate(10000, weight: 100, rate: 1, resultMinutes: 60)
		XCTAssertEqual(rd, 0.6)
	}
	
	func testFlolanUpdateResult() {
		let flolan = Flolan()
		
		let rd = flolan.updateResult("100", concentration: "10000", rate: "1", resultMinutes: nil)
		XCTAssertEqual(rd, "0.6")
	}
    
    func testDoseTypeStartingValue() {
        var result = DoseType.Empty.startingValue()
        XCTAssertEqual(result, Double(0.0))
        
        result = DoseType.AdultKilgrams.startingValue()
        XCTAssertTrue(result > 0.0)
        
        result = DoseType.MedicinceConcentrationNanogramsPerMilliliter.startingValue()
        XCTAssertTrue(result > 0.0)
        
        result = DoseType.Rate.startingValue()
        XCTAssertTrue(result != 0.0)
    }
	
}
