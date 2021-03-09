//
//  RequestSavingUITests.swift
//  testRequestUITests
//
//  Created by Źmicier Fiedčanka on 5.03.21.
//

import XCTest

class RequestSavingUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()

        // Q: Is there any faster way to initialize state?
        app.tables.buttons["Insert hardware, СТБ 34.101.1-2014, СТБ 34.101.2-2014, СТБ 34.101.3-2014"].tap()
        app.tables.buttons["Insert software, СТБ 34.101.27-2011 (класс 1 или 2)"].tap()
        app.tables.buttons["Insert brng, СТБ 34.101.27-2011 (п. 5.6) или СТБ 34.101.47-2017 (п. 6.2 или 6.3)"].tap()
        app.buttons["GO!"].tap()
        app.navigationBars.buttons["Add"].tap()
    }
}
