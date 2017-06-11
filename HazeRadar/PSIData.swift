//
//  PSIData.swift
//  HazeRadar
//
//  Created by Sajid Kalla on 11/6/17.
//  Copyright © 2017 Bytters. All rights reserved.
//

import Foundation


enum RegionName: String {
    case East, Central, South, North, West
}

struct PSIData {
    var dateTime:String?
    var east:PSIRegion?
    var central:PSIRegion?
    var south:PSIRegion?
    var north:PSIRegion?
    var west:PSIRegion?
}
