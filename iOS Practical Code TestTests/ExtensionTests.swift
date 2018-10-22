//
//  ExtensionTests.swift
//  iOS Practical Code TestTests
//
//  Created by Brett Cocking on 2018/10/22.
//  Copyright © 2018 Trademark Technology. All rights reserved.
//

import XCTest
@testable import iOS_Practical_Code_Test

class ExtensionTests: XCTestCase {

    func testUIColorFromHexValueExtension() {
        let whiteFromUIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        let whiteFromHexValue = UIColor().fromHexValue(hex: "#FFFFFF")
        
        XCTAssertEqual(whiteFromUIColor, whiteFromHexValue)
    }

    func testHtmlToStringExtension() {
        let htmlString = "Jordi G&#225;mez"
        
        XCTAssertEqual(htmlString.htmlToString, "Jordi Gámez")
    }
    
    func testDateToOrdinalStringExtension() {
        let date = Date(timeIntervalSince1970: TimeInterval(exactly: 1537276423)!)
        
        XCTAssertEqual(date.toOrdinalDateString(), "18th September 2018")
    }
    
    func testDateToTimeStringExtension() {
        let date = Date(timeIntervalSince1970: TimeInterval(exactly: 1537276423)!)
        
        XCTAssertEqual(date.toTimeString(), "15:13")
    }

}
