//
//  PSIService_Integration_Tests.swift
//  GetMeThePSITests
//
//  Created by SYAM SASIDHARAN on 26/12/17.
//  Copyright © 2017 syam00. All rights reserved.
//
import XCTest
@testable import GetMeThePSI

class PSIService_Integration_Tests: XCTestCase {

    var subject: PSIService!

    override func setUp() {
        super.setUp()
        subject = PSIService()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_Fetch_PSI_ReturnsData() {
        
        var responseData: Data?
        let url = "https://api.data.gov.sg/v1/environment/psi?date_time=2017-12-21T09%3A00%3A00"
        let apiKey = "B5FywOte5AKpgldqG1Hgvutk3l3XMzmh"
        
        let serviceExpectations = expectation(description: "Wait for service to return the data")

        subject.getTheCurrentPSIReadings(url: url, apiKey: apiKey) { (data, error) in
            responseData = data
            serviceExpectations.fulfill()

        }
        
        waitForExpectations(timeout: 30, handler: nil)
        XCTAssertNotNil(responseData)
        
    }
    
}
