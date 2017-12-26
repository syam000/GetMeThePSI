//
//  PSIServiceTests.swift
//  GetMeThePSITests
//
//  Created by SYAM SASIDHARAN on 26/12/17.
//  Copyright © 2017 syam00. All rights reserved.
//
import XCTest
@testable import GetMeThePSI

class PSIServiceTests: XCTestCase {

    var subject: PSIService!
    let session = MockURLSession()
    
    override func setUp() {
        super.setUp()
        
        subject = PSIService(session: session)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_GET_CURRENT_PSI_ValidateTheURL() {
        let url = "https://api.data.gov.sg/v1/environment/psi?date_time=2017-12-21T09%3A00%3A00"
        
        subject.getTheCurrentPSIReadings(url: url, apiKey: "") { (_, _) in }

        XCTAssert(session.lastURL == url)
    }
    
    func test_GET_CURRENT_PSI_ValidateTheAPIKey() {
        let url = "https://api.data.gov.sg/v1/environment/psi?date_time=2017-12-21T09%3A00%3A00"
        let apiKey = "B5FywOte5AKpgldqG1Hgvutk3l3XMzmh"
        
        subject.getTheCurrentPSIReadings(url: url, apiKey: apiKey) { (_, _) in }
        
        XCTAssert(session.lastApiKey == apiKey)
    }
    
    func test_GET_CURRENT_PSI_ValidateTheSessionTask() {
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        
        let url = "https://api.data.gov.sg/v1/environment/psi?date_time=2017-12-21T09%3A00%3A00"

        subject.getTheCurrentPSIReadings(url: url, apiKey: "") { (_, _) in }

        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func test_GET_CURRENT_PSI_WithResponseData_ReturnsTheData() {
        let expectedData = "{s}".data(using: String.Encoding.utf8)
        session.nextData = expectedData
        
        var responseData: Data?
        
        let url = "https://api.data.gov.sg/v1/environment/psi?date_time=2017-12-21T09%3A00%3A00"
        
        subject.getTheCurrentPSIReadings(url: url, apiKey: "") { (data, _) in
            responseData = data
        }
        
        XCTAssertEqual(responseData, expectedData)
    }
    
    func test_GET_CURRENT_PSI_WithServiceError_ReturnsUnsupportedUrlError() {
    
        let expectedError = ServiceError.getError(with: 1000)
        session.nextError = expectedError
        
        var serviceError: ServiceError?
        
        subject.getTheCurrentPSIReadings(url: "", apiKey: "") { (data, error) in
            serviceError = error as? ServiceError
        }
        
        XCTAssertEqual(serviceError, expectedError)

    }
    
    func test_GET_CURRENT_PSI_WithServiceError_ReturnsInvalidApiKeyError() {
        
        let expectedError = ServiceError.getError(with: 1001)
        session.nextError = expectedError
        
        var serviceError: ServiceError?
        
        let url = "https://api.data.gov.sg/v1/environment/psi?date_time=2017-12-21T09%3A00%3A00"

        subject.getTheCurrentPSIReadings(url: url, apiKey: "") { (data, error) in
            serviceError = error as? ServiceError
        }
        
        XCTAssertEqual(serviceError, expectedError)
        
    }
}
