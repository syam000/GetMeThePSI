//
//  MapViewViewModel.swift
//  GetMeThePSI
//
//  Created by SYAM SASIDHARAN on 1/1/18.
//  Copyright © 2018 syam00. All rights reserved.
//

import Foundation

class MapViewViewModel: MapViewViewModelProtocol {
    
    let psiService = PSIService()
    var lastPSIResponse : PSIResponse?
    
    private var baseUrl = ""
    private var apiKey = ""
    
    init(with baseUrl : String, apiKey : String) {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
    }
    
    func formatDateSToString(date : Date?) -> String {
        
        guard let date = date else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let result = dateFormatter.string(from: date)
        
        return result
    }

    func getTheUrlFromDate(date : Date?) -> String {
        return baseUrl + "?date_time" + formatDateSToString(date:date)
    }
    
    func getPSIRegions(date : Date, completion : @escaping ([PSIRegion]?, Error?) -> Swift.Void) {
        
        psiService.getTheCurrentPSIReadings(url: getTheUrlFromDate(date: date), apiKey: apiKey) { (data, error) in
            
            if let data = data {
                let decoder = JSONDecoder()
                self.lastPSIResponse = try! decoder.decode(PSIResponse.self, from: data)
                completion(self.lastPSIResponse?.region_metadata, nil)
            }
            else {
                completion(nil, error)
            }
        }
    }
    
    func getReadings(of regionName: String) -> PSIReadings {
        var readings = PSIReadings()
        
        guard let psiResponse = lastPSIResponse else {
            return readings
        }
        
        guard let psiItem = psiResponse.items?.first else {
            return readings
        }
        
        guard let readingsCollection = psiItem.readings else {
            return readings
        }
        
        if let value = readingsCollection.co_eight_hour_max?[regionName] {
            readings.co_eight_hour_max = value
        }
        
        if let value = readingsCollection.co_sub_index?[regionName] {
            readings.co_sub_index = value
        }
        
        if let value = readingsCollection.no2_one_hour_max?[regionName] {
            readings.no2_one_hour_max = value
        }
        
        if let value = readingsCollection.o3_eight_hour_max?[regionName] {
            readings.o3_eight_hour_max = value
        }
        
        if let value = readingsCollection.o3_sub_index?[regionName] {
            readings.o3_sub_index = value
        }
        
        if let value = readingsCollection.pm10_sub_index?[regionName] {
            readings.pm10_sub_index = value
        }
        
        if let value = readingsCollection.pm10_twenty_four_hourly?[regionName] {
            readings.pm10_twenty_four_hourly = value
        }
        
        if let value = readingsCollection.pm25_sub_index?[regionName] {
            readings.pm25_sub_index = value
        }
        
        if let value = readingsCollection.pm25_twenty_four_hourly?[regionName] {
            readings.pm25_twenty_four_hourly = value
        }
        
        if let value = readingsCollection.psi_twenty_four_hourly?[regionName] {
            readings.psi_twenty_four_hourly = value
        }
        
        if let value = readingsCollection.so2_sub_index?[regionName] {
            readings.so2_sub_index = value
        }
        
        if let value = readingsCollection.so2_twenty_four_hourly?[regionName] {
            readings.so2_twenty_four_hourly = value
        }
        
        return readings
    }
}

