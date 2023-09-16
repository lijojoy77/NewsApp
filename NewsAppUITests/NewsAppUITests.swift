//
//  NewsAppUITests.swift
//  NewsAppUITests
//
//  Created by Lijo Joy on 12/09/2023.
//

import XCTest

class NewsAppUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    /// Search and listing test
    func testSearchingAndVerifyingCell() {
           let app = XCUIApplication()
           let searchField = app.textFields["Search news here ..."]
           
           // Tap on the search field and enter "iPhone"
           searchField.tap()
           searchField.typeText("iPhone")
           
           // Wait for a moment to allow search results to load
           sleep(2)
           
      //  print(app.debugDescription)
          
        let macRumorsCell = app.tables.cells.staticTexts["iPhone 15 and iPhone 15 Pro Models Now Available for Pre-Order - MacRumors"]
        let existsExpectation = expectation(for: NSPredicate(format: "exists == true"), evaluatedWith: macRumorsCell, handler: nil)

        // Set a timeout for the expectation (adjust as needed)
        let timeout: TimeInterval = 20.0

        // Wait for the expectation to fulfill
        wait(for: [existsExpectation], timeout: timeout)

 
        XCTAssertTrue(macRumorsCell.exists, "MacRumors cell should exist")

        // Check if the cell's label contains "MacRumors"
        XCTAssertTrue(macRumorsCell.label.contains("MacRumors"), "MacRumors cell label should contain 'MacRumors'")
       }
    
    /// Tapping test
    func testTappingOnResultCell() {
            let app = XCUIApplication()
            let searchField = app.textFields["Search news here ..."]
            
            // Tap on the search field and enter "iPhone"
            searchField.tap()
            searchField.typeText("iPhone")
            
            // Wait for a moment to allow search results to load
            sleep(2)
            
            // Find the MacRumors cell
            let macRumorsCell = app.tables.cells.staticTexts["iPhone 15 and iPhone 15 Pro Models Now Available for Pre-Order - MacRumors"]
            
            // Check if the cell exists
            XCTAssertTrue(macRumorsCell.exists, "MacRumors cell should exist")
            
            // Tap on the cell
            macRumorsCell.tap()
            
        // Check if a navigation bar with a specific title exists on the next screen
        XCTAssertTrue(app.navigationBars["iPhone 15 and iPhone 15 Pro Models Now Available for Pre-Order - MacRumors"].exists, "MacRumors News navigation bar should exist")
        
        }
    
   }
