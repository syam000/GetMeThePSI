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
    
    let url = "https://api.data.gov.sg/v1/environment/psi?date_time=2017-12-21T09%3A00%3A00"
    let apiKey = "B5FywOte5AKpgldqG1Hgvutk3l3XMzmh"

    override func setUp() {
        super.setUp()
        
        subject = PSIService(session: session)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_GET_CURRENT_PSI_ValidateTheURL() {
        
        subject.getTheCurrentPSIReadings(url: url, apiKey: "") { (_, _) in }

        XCTAssert(session.lastURL == url)
    }
    
    func test_GET_CURRENT_PSI_ValidateTheAPIKey() {
        
        subject.getTheCurrentPSIReadings(url: url, apiKey: apiKey) { (_, _) in }
        
        XCTAssert(session.lastApiKey == apiKey)
    }
    
    func test_GET_CURRENT_PSI_ValidateTheSessionTask() {
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask

        subject.getTheCurrentPSIReadings(url: url, apiKey: apiKey) { (_, _) in }

        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func test_GET_CURRENT_PSI_WithResponseData_ReturnsSomeData() {
        let expectedData = "{s}".data(using: String.Encoding.utf8)
        session.nextData = expectedData
        
        var responseData: Data?
        
        subject.getTheCurrentPSIReadings(url: url, apiKey: apiKey) { (data, _) in
            responseData = data
        }
        
        XCTAssertEqual(responseData, expectedData)
    }
    
    func test_GET_CURRENT_PSI_WithResponseData_ReturnsValidData() {
        let expectedData = "{{\"region_metadata\":[{\"name\":\"west\",\"label_location\":{\"latitude\":1.35735,\"longitude\":103.7}},{\"name\":\"national\",\"label_location\":{\"latitude\":0,\"longitude\":0}},{\"name\":\"east\",\"label_location\":{\"latitude\":1.35735,\"longitude\":103.94}},{\"name\":\"central\",\"label_location\":{\"latitude\":1.35735,\"longitude\":103.82}},{\"name\":\"south\",\"label_location\":{\"latitude\":1.29587,\"longitude\":103.82}},{\"name\":\"north\",\"label_location\":{\"latitude\":1.41803,\"longitude\":103.82}}],\"items\":[{\"timestamp\":\"2017-12-21T09:00:00+08:00\",\"update_timestamp\":\"2017-12-21T09:06:18+08:00\",\"readings\":{\"o3_sub_index\":{\"west\":42,\"national\":42,\"east\":28,\"central\":34,\"south\":33,\"north\":32},\"pm10_twenty_four_hourly\":{\"west\":29,\"national\":44,\"east\":39,\"central\":32,\"south\":31,\"north\":44},\"pm10_sub_index\":{\"west\":29,\"national\":44,\"east\":39,\"central\":32,\"south\":31,\"north\":44},\"co_sub_index\":{\"west\":6,\"national\":8,\"east\":4,\"central\":8,\"south\":7,\"north\":6},\"pm25_twenty_four_hourly\":{\"west\":14,\"national\":23,\"east\":19,\"central\":17,\"south\":17,\"north\":23},\"so2_sub_index\":{\"west\":4,\"national\":4,\"east\":1,\"central\":3,\"south\":2,\"north\":1},\"co_eight_hour_max\":{\"west\":0.61,\"national\":0.75,\"east\":0.4,\"central\":0.75,\"south\":0.71,\"north\":0.61},\"no2_one_hour_max\":{\"west\":5,\"national\":35,\"east\":35,\"central\":31,\"south\":31,\"north\":27},\"so2_twenty_four_hourly\":{\"west\":6,\"national\":6,\"east\":2,\"central\":4,\"south\":3,\"north\":2},\"pm25_sub_index\":{\"west\":53,\"national\":63,\"east\":58,\"central\":57,\"south\":56,\"north\":63},\"psi_twenty_four_hourly\":{\"west\":53,\"national\":63,\"east\":58,\"central\":57,\"south\":56,\"north\":63},\"o3_eight_hour_max\":{\"west\":100,\"national\":100,\"east\":65,\"central\":80,\"south\":77,\"north\":76}}}],\"api_info\":{\"status\":\"healthy\"}}}".data(using: String.Encoding.utf8)
        session.nextData = expectedData
        
        var responseData: Data?
        
        subject.getTheCurrentPSIReadings(url: url, apiKey: apiKey) { (data, _) in
            responseData = data
        }
        
        XCTAssertEqual(responseData, expectedData)
    }
    
    func test_GET_CURRENT_PSI_WithResponseData_ReturnsInvalidData() {
        let expectedData = "".data(using: String.Encoding.utf8)
        session.nextData = expectedData
        
        var responseData: Data?
        
        subject.getTheCurrentPSIReadings(url: url, apiKey: apiKey) { (data, _) in
            responseData = data
        }
        
        XCTAssertEqual(responseData, expectedData)
    }
    
    func test_GET_CURRENT_PSI_WithServiceError_ReturnsUnsupportedUrlError() {
    
        let expectedError = ServiceError.getError(with: 1000)
        session.nextError = expectedError
        
        var serviceError: ServiceError?
        
        subject.getTheCurrentPSIReadings(url: url, apiKey: apiKey) { (data, error) in
            serviceError = error as? ServiceError
        }
        
        XCTAssertEqual(serviceError, expectedError)

    }
    
    func test_GET_CURRENT_PSI_WithServiceError_ReturnsInvalidApiKeyError() {
        
        let expectedError = ServiceError.getError(with: 1001)
        session.nextError = expectedError
        
        var serviceError: ServiceError?
        
        subject.getTheCurrentPSIReadings(url: url, apiKey: apiKey) { (data, error) in
            serviceError = error as? ServiceError
        }
        
        XCTAssertEqual(serviceError, expectedError)
        
    }
}
