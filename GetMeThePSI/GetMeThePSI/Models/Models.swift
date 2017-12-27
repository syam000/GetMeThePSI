//
//  Models.swift
//  GetMeThePSI
//
//  Created by SYAM SASIDHARAN on 26/12/17.
//  Copyright © 2017 syam00. All rights reserved.
//

import UIKit

struct  PSIRegion : Codable {
    let name : String
    let label_location : PSILocation
}

struct PSILocation : Codable {
    let latitude : Double
    let longitude : Double
}

struct PSIItem : Codable {
    let timestamp : String
    let readings : PSIReadings
}

struct PSIReadings : Codable {
    let o3_sub_index : Dictionary <String, Int>
    let pm10_twenty_four_hourly : Dictionary <String, Int>
    let pm10_sub_index : Dictionary <String, Int>
    let co_sub_index : Dictionary <String, Int>
    let pm25_twenty_four_hourly : Dictionary <String, Int>
    let so2_sub_index : Dictionary <String, Int>
    let co_eight_hour_max : Dictionary <String, Float>
    let no2_one_hour_max : Dictionary <String, Int>
    let so2_twenty_four_hourly : Dictionary <String, Int>
    let pm25_sub_index : Dictionary <String, Int>
    let psi_twenty_four_hourly : Dictionary <String, Int>
    let o3_eight_hour_max : Dictionary <String, Int>
}

struct PSIResponse : Codable {
    let region_metadata : [PSIRegion]
    let items : [PSIItem]
}

