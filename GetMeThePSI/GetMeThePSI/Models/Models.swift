//
//  Models.swift
//  GetMeThePSI
//
//  Created by SYAM SASIDHARAN on 26/12/17.
//  Copyright © 2017 syam00. All rights reserved.
//

import UIKit

struct  PSIRegion {
    var name : String?
    var label_location : PSILocation?
    var readings : [PSIReading]?
}

struct PSILocation {
    var latitude : Double?
    var longitude : Double?
}

struct PSIReading {
    var readingMetaData : String?
    var value : Double?
}
