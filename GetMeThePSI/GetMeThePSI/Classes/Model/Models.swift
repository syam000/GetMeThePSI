//
//  Models.swift
//  GetMeThePSI
//
//  Created by SYAM SASIDHARAN on 26/12/17.
//  Copyright © 2017 syam00. All rights reserved.
//

import UIKit
import MapKit


struct  PSIRegion : Codable{
    var name : String?
    var label_location : PSILocation?
}

struct PSILocation : Codable {
    var latitude : Double?
    var longitude : Double?
}

struct PSIItem : Codable {
    var timestamp : String?
    var readings : PSIReadingsCollection?
}

struct PSIReadingsCollection : Codable {
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

struct PSIReadings {
    var o3_sub_index : Int = 0
    var pm10_twenty_four_hourly : Int = 0
    var pm10_sub_index : Int = 0
    var co_sub_index : Int = 0
    var pm25_twenty_four_hourly : Int = 0
    var so2_sub_index : Int = 0
    var co_eight_hour_max :Float = 0.0
    var no2_one_hour_max : Int = 0
    var so2_twenty_four_hourly : Int = 0
    var pm25_sub_index : Int = 0
    var psi_twenty_four_hourly : Int = 0
    var o3_eight_hour_max : Int = 0
    
    func toString() -> String {
        var result = ""
        result = "O3 Sub Index: \(o3_sub_index) \n PM10 24hourly : \(pm10_twenty_four_hourly) \n PM10 Sub Index : \(pm10_sub_index) \n CO Sub Index : \(co_sub_index) \n PM25 24hourly : \(pm25_twenty_four_hourly) \n SO2 Sub Index : \(so2_sub_index) \n CO 8hour Max : \(co_eight_hour_max) \n NO2 1hour max : \(no2_one_hour_max) \n SO2 24hourly : \(so2_twenty_four_hourly) \n PM25 Sub Index : \(pm25_sub_index) \n PSI 24hourly : \(psi_twenty_four_hourly) \n O3 8hour max : \(o3_eight_hour_max) \n"
        
        return result
    }
}
