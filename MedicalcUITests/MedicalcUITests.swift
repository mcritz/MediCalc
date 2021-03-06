//
//  MedicalcUITests.swift
//  MedicalcUITests
//
//  Created by Critz, Michael on 10/5/15.
//  Copyright © 2015 Map of the Unexplored. All rights reserved.
//

import XCTest

class MedicalcUITests: XCTestCase {
	let app = XCUIApplication()
	
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
		app.launchArguments = [ "USE_MOCK_SERVER" ]
		app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConcentrationUI() {
		XCTAssert(app.textFields["doseInput"].exists, "doesInput element exists")
		XCTAssert(app.textFields["concentrationInput"].exists, "concentrationInput element exists")
		XCTAssert(app.textFields["rateInput"].exists, "rateInput element exists")
		XCTAssert(app.staticTexts["result"].exists, "result element exists")
		XCTAssertTrue(app.buttons["dismiss"].exists)
    }
	
	
	func testPickers() {
        let inputs = ["concentrationInput", "rateInput", "doseInput"]
        
        for field in inputs {
            app.textFields[field].tap()
            XCTAssertTrue(app.pickers["doseInput"].exists)
            app.buttons["dismiss"].tap()
            XCTAssertFalse(app.pickers["doseInput"].exists)
        }
    }
}
