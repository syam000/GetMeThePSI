//
//  MapView.swift
//  GetMeThePSI
//
//  Created by SYAM SASIDHARAN on 1/1/18.
//  Copyright © 2018 syam00. All rights reserved.
//

import Foundation

protocol MapView {
    func annotateRegions(regions : [PSIRegion]?)
    func showRegionPSI(readings : PSIReadings?)
    func showRegionPSIDetailts(region : PSIRegion)
    func loadContent()
    func showLoading(show : Bool)
    func showError(message : String)
}
