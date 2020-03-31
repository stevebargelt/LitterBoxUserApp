//
//  LitterBoxUserUITests.swift
//  LitterBoxUserUITests
//
//  Created by Steve Bargelt on 3/28/20.
//  Copyright © 2020 Steve Bargelt. All rights reserved.
//

import XCTest

class LitterBoxUserUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
    }
    
    func testScreenshot() throws {
        setupSnapshot(app)
        app.launch()
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("appleappstore@harebrained-apps.com")
        let passwordTextField = app.secureTextFields["Password"]
        passwordTextField.tap()
        passwordTextField.typeText("harebrained-apps-apple\n")
        app.buttons["Sign in"].tap()

        snapshot("01Cats")
//        //XCTAssertTrue(app.isDisplayingCatsView, "Cat View (list) is not displayed")
//        let userButton = app.navigationBars["Cats"].buttons["User Profile"]
//        userButton.tap()
//        snapshot("02UserSettings")
        //XCTAssertTrue(app.isDisplayingUserProfileSheet, "User Profile is not displayed")
//        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 0).swipeDown()

        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Bear\nBlack"]/*[[".cells.buttons[\"Bear\\nBlack\"]",".buttons[\"Bear\\nBlack\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("02CatDetail")
        app.buttons["Litter Trips"].tap()
        snapshot("03LitterTrips")
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["2020-03-29 06:17:27\n1.00\nout\n1.00"]/*[[".cells.buttons[\"2020-03-29 06:17:27\\n1.00\\nout\\n1.00\"]",".buttons[\"2020-03-29 06:17:27\\n1.00\\nout\\n1.00\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("04LitterTripDetail")

    }
    
//    func testLogin() throws {
//
//
//        let emailTextField = app.textFields["Email"]
//        emailTextField.tap()
//        app/*@START_MENU_TOKEN@*/.staticTexts["Continue"]/*[[".otherElements[\"UIContinuousPathIntroductionView\"]",".buttons[\"Continue\"].staticTexts[\"Continue\"]",".staticTexts[\"Continue\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
//        emailTextField.tap()
//        app.secureTextFields["Password"].tap()
//
//
//    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}

//extension XCUIApplication {
//    var isDisplayingCatsView: Bool {
//        return otherElements["CATS_VIEW"].exists
//    }
//}
//
//extension XCUIApplication {
//    var isDisplayingUserProfileSheet: Bool {
//        return otherElements["USER_PROFILE"].exists
//    }
//}
