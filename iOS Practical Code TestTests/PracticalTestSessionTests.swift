//
//  iOS_Practical_Code_TestTests.swift
//  iOS Practical Code TestTests
//
//  Created by Brett Cocking on 2018/10/20.
//  Copyright © 2018 Trademark Technology. All rights reserved.
//

import XCTest
@testable import iOS_Practical_Code_Test

class PracticalTestSessionTests: XCTestCase {
    
    var sessionUnderTest: URLSession!

    override func setUp() {
        super.setUp()
        sessionUnderTest = URLSession(configuration: .default)
    }

    override func tearDown() {
        sessionUnderTest = nil
        super.tearDown()
    }

    func testCallToApiCompletes() {
        let url = URL(string: "https://api.stackexchange.com//2.2/questions?order=desc&sort=activity&site=stackoverflow")
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        let task = sessionUnderTest.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            
            promise.fulfill()
        }
        task.resume()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
}
