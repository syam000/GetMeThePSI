//
//  PSIResponseTests.swift
//  GetMeThePSITests
//
//  Created by SYAM SASIDHARAN on 27/12/17.
//  Copyright © 2017 syam00. All rights reserved.
//

import XCTest
@testable import GetMeThePSI

class PSIResponseTests: XCTestCase {
    
    let samplePSIResponse = "{\n  \"region_metadata\": [\n    {\n      \"name\": \"west\",\n      \"label_location\": {\n        \"latitude\": 1.35735,\n        \"longitude\": 103.7\n      }\n    },\n    {\n      \"name\": \"national\",\n      \"label_location\": {\n        \"latitude\": 0,\n        \"longitude\": 0\n      }\n    },\n    {\n      \"name\": \"east\",\n      \"label_location\": {\n        \"latitude\": 1.35735,\n        \"longitude\": 103.94\n      }\n    },\n    {\n      \"name\": \"central\",\n      \"label_location\": {\n        \"latitude\": 1.35735,\n        \"longitude\": 103.82\n      }\n    },\n    {\n      \"name\": \"south\",\n      \"label_location\": {\n        \"latitude\": 1.29587,\n        \"longitude\": 103.82\n      }\n    },\n    {\n      \"name\": \"north\",\n      \"label_location\": {\n        \"latitude\": 1.41803,\n        \"longitude\": 103.82\n      }\n    }\n  ],\n  \"items\": [\n    {\n      \"timestamp\": \"2017-12-21T09:00:00+08:00\",\n      \"update_timestamp\": \"2017-12-21T09:06:18+08:00\",\n      \"readings\": {\n        \"o3_sub_index\": {\n          \"west\": 42,\n          \"national\": 42,\n          \"east\": 28,\n          \"central\": 34,\n          \"south\": 33,\n          \"north\": 32\n        },\n        \"pm10_twenty_four_hourly\": {\n          \"west\": 29,\n          \"national\": 44,\n          \"east\": 39,\n          \"central\": 32,\n          \"south\": 31,\n          \"north\": 44\n        },\n        \"pm10_sub_index\": {\n          \"west\": 29,\n          \"national\": 44,\n          \"east\": 39,\n          \"central\": 32,\n          \"south\": 31,\n          \"north\": 44\n        },\n        \"co_sub_index\": {\n          \"west\": 6,\n          \"national\": 8,\n          \"east\": 4,\n          \"central\": 8,\n          \"south\": 7,\n          \"north\": 6\n        },\n        \"pm25_twenty_four_hourly\": {\n          \"west\": 14,\n          \"national\": 23,\n          \"east\": 19,\n          \"central\": 17,\n          \"south\": 17,\n          \"north\": 23\n        },\n        \"so2_sub_index\": {\n          \"west\": 4,\n          \"national\": 4,\n          \"east\": 1,\n          \"central\": 3,\n          \"south\": 2,\n          \"north\": 1\n        },\n        \"co_eight_hour_max\": {\n          \"west\": 0.61,\n          \"national\": 0.75,\n          \"east\": 0.4,\n          \"central\": 0.75,\n          \"south\": 0.71,\n          \"north\": 0.61\n        },\n        \"no2_one_hour_max\": {\n          \"west\": 5,\n          \"national\": 35,\n          \"east\": 35,\n          \"central\": 31,\n          \"south\": 31,\n          \"north\": 27\n        },\n        \"so2_twenty_four_hourly\": {\n          \"west\": 6,\n          \"national\": 6,\n          \"east\": 2,\n          \"central\": 4,\n          \"south\": 3,\n          \"north\": 2\n        },\n        \"pm25_sub_index\": {\n          \"west\": 53,\n          \"national\": 63,\n          \"east\": 58,\n          \"central\": 57,\n          \"south\": 56,\n          \"north\": 63\n        },\n        \"psi_twenty_four_hourly\": {\n          \"west\": 53,\n          \"national\": 63,\n          \"east\": 58,\n          \"central\": 57,\n          \"south\": 56,\n          \"north\": 63\n        },\n        \"o3_eight_hour_max\": {\n          \"west\": 100,\n          \"national\": 100,\n          \"east\": 65,\n          \"central\": 80,\n          \"south\": 77,\n          \"north\": 76\n        }\n      }\n    }\n  ],\n  \"api_info\": {\n    \"status\": \"healthy\"\n  }\n}"
    
    var actualPSIResponse : PSIResponse!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_PSIResponse_Decoder_ValidData() {

        let jsonData = samplePSIResponse.data(using: String.Encoding.utf8)
        let decoder = JSONDecoder()
        actualPSIResponse = try! decoder.decode(PSIResponse.self, from: jsonData!)
        
        XCTAssertNotNil(actualPSIResponse)
    }
    
    func test_PSI_Response_o3_eight_hour_max_value_valid() {
        let region = "west"
        let expectedValue = 100
        
        let jsonData = samplePSIResponse.data(using: String.Encoding.utf8)
        let decoder = JSONDecoder()
        actualPSIResponse = try! decoder.decode(PSIResponse.self, from: jsonData!)
                
        if let _ = actualPSIResponse {
            if  let psiItems = actualPSIResponse?.items?.first {
                if let readings = psiItems.readings {
                    if let actual_o3_eight_hour_max_value = readings.o3_eight_hour_max![region] {
                        XCTAssert(expectedValue == actual_o3_eight_hour_max_value)
                    }
                    else {
                        XCTFail("Invalid PSI Response")
                    }
                }
                else {
                    XCTFail("Invalid PSI Response")
                }
            }
            else {
                XCTFail("Invalid PSI Response")
            }
        }
        else {
            XCTFail("Invalid PSI Response")
        }
    }

}
