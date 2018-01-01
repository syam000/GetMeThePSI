//
//  MapViewModel.swift
//  GetMeThePSI
//
//  Created by SYAM SASIDHARAN on 1/1/18.
//  Copyright © 2018 syam00. All rights reserved.
//

import Foundation

protocol MapViewViewModelProtocol {
    func getPSIRegions(date : Date, completion : @escaping ([PSIRegion]?, Error?) -> Swift.Void)
    func getReadings(of regionName : String) -> PSIReadings
}
