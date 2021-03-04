//
//  testRequestUITests.swift
//  testRequestUITests
//
//  Created by Źmicier Fiedčanka on 4.03.21.
//

import XCTest

class MechanismPickerUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testSignleMechanismInsertion() {
        let app = XCUIApplication()
        app.launch()

        app.tables.buttons["Insert software, СТБ 34.101.27-2011 (класс 1 или 2)"].tap()
        XCTAssert(app.tables.buttons["Delete software, СТБ 34.101.27-2011 (класс 1 или 2)"].exists)
    }

    func testSignleMechanismInsertionAndDeletion() {
        let app = XCUIApplication()
        app.launch()

        app.tables.buttons["Insert hardware, СТБ 34.101.1-2014, СТБ 34.101.2-2014, СТБ 34.101.3-2014"].tap()
        app.tables.buttons["Delete hardware, СТБ 34.101.1-2014, СТБ 34.101.2-2014, СТБ 34.101.3-2014"].tap()
        app.tables.buttons["Delete"].tap()

        XCTAssert(!app.tables.buttons["Delete hardware, СТБ 34.101.1-2014, СТБ 34.101.2-2014, СТБ 34.101.3-2014"].exists)
        XCTAssert(app.tables.buttons["Insert hardware, СТБ 34.101.1-2014, СТБ 34.101.2-2014, СТБ 34.101.3-2014"].exists)
    }

    func testRefreshingButton_SignleMechanism() {
        let app = XCUIApplication()
        app.launch()

        XCTAssert(!app.buttons["Refresh"].exists)

        app.tables.buttons["Insert brng, СТБ 34.101.27-2011 (п. 5.6) или СТБ 34.101.47-2017 (п. 6.2 или 6.3)"].tap()
        app.buttons["Refresh"].tap()

        XCTAssert(!app.buttons["Refresh"].exists)
        XCTAssert(!app.tables.buttons["Delete brng, СТБ 34.101.27-2011 (п. 5.6) или СТБ 34.101.47-2017 (п. 6.2 или 6.3)"].exists)
        XCTAssert(app.tables.buttons["Insert brng, СТБ 34.101.27-2011 (п. 5.6) или СТБ 34.101.47-2017 (п. 6.2 или 6.3)"].exists)
    }

    func testActionButton() {
        let app = XCUIApplication()
        app.launch()

        XCTAssert(!app.buttons["GO!"].exists)

        app.tables.buttons["Insert brng, СТБ 34.101.27-2011 (п. 5.6) или СТБ 34.101.47-2017 (п. 6.2 или 6.3)"].tap()
        app.buttons["GO!"].tap()

        XCTAssert(app.navigationBars["Результаты"].exists)
    }
}
