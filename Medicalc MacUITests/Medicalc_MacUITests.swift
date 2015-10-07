//
//  Medicalc_MacUITests.swift
//  Medicalc MacUITests
//
//  Created by Michael Critz on 10/6/15.
//  Copyright © 2015 Map of the Unexplored. All rights reserved.
//

import XCTest

class Medicalc_MacUITests: XCTestCase {
	
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
        super.tearDown()
    }
    
	func testConcentrationUI() {
		XCTAssert(app.textFields["doseInput"].exists, "doesInput element exists")
		XCTAssert(app.textFields["concentrationinput"].exists, "concentrationInput element exists")
		XCTAssert(app.staticTexts["result"].exists, "result element exists")
	}
	
}
