//
//  Models.swift
//  GetMeThePSI
//
//  Created by SYAM SASIDHARAN on 26/12/17.
//  Copyright © 2017 syam00. All rights reserved.
//

import UIKit


struct  PSIRegion : Codable {
    var name : String?
    var label_location : PSILocation?
}

struct PSILocation : Codable {
    var latitude : Double?
    var longitude : Double?
}

struct PSIItem : Codable {
    var timestamp : String?
    var readings : PSIReadings?
}

struct PSIReadings : Codable {
    var o3_sub_index : Dictionary <String, Int>?
    var pm10_twenty_four_hourly : Dictionary <String, Int>?
    var pm10_sub_index : Dictionary <String, Int>?
    var co_sub_index : Dictionary <String, Int>?
    var pm25_twenty_four_hourly : Dictionary <String, Int>?
    var so2_sub_index : Dictionary <String, Int>?
    var co_eight_hour_max : Dictionary <String, Float>?
    var no2_one_hour_max : Dictionary <String, Int>?
    var so2_twenty_four_hourly : Dictionary <String, Int>?
    var pm25_sub_index : Dictionary <String, Int>?
    var psi_twenty_four_hourly : Dictionary <String, Int>?
    var o3_eight_hour_max : Dictionary <String, Int>?
}

struct PSIResponse : Codable {
    var region_metadata : [PSIRegion]?
    var items : [PSIItem]?
}

