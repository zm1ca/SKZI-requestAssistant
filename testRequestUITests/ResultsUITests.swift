//
//  ResultsUITests.swift
//  testRequestUITests
//
//  Created by Źmicier Fiedčanka on 4.03.21.
//

import XCTest

class ResultsUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()

        // Q: Is there any faster way to initialize state?
        app.tables.buttons["Insert hardware, СТБ 34.101.1-2014, СТБ 34.101.2-2014, СТБ 34.101.3-2014"].tap()
        app.tables.buttons["Insert software, СТБ 34.101.27-2011 (класс 1 или 2)"].tap()
        app.tables.buttons["Insert brng, СТБ 34.101.27-2011 (п. 5.6) или СТБ 34.101.47-2017 (п. 6.2 или 6.3)"].tap()
        app.buttons["GO!"].tap()

    }

    func testBackButton() {
        app.navigationBars.buttons["Проверка"].tap()

        XCTAssert(app.navigationBars["Проверка"].exists)
    }

    func testAddButton() {
        app.navigationBars.buttons["Add"].tap()

        XCTAssert(app.textFields["Название СКЗИ"].exists)
        XCTAssert(app.textFields["Организация"].exists)
        XCTAssert(app.buttons ["Отмена"].exists)
        XCTAssert(app.buttons ["Ок"].exists)
    }

    func testAccessory() {
        app.tables.cells.element(boundBy: 0).buttons["More Info"].tap()

        XCTAssert(app.alerts["Примечание к пункту 16.1"].exists)

        app.alerts.scrollViews.buttons["Ок"].tap()

        XCTAssert(app.alerts.count == 0)
    }
}
