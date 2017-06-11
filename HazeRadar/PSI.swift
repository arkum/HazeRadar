//
//  PSI.swift
//  HazeRadar
//
//  Created by Sajid Kalla on 11/6/17.
//  Copyright © 2017 Bytters. All rights reserved.
//

import Foundation
import SwiftyJSON


class PSI{
    
    func load() -> PSIData {
        return loadData(json: JSON(self.loadLocal()))
    }
    
    var readings:JSON = []
    func loadData(json:JSON) -> PSIData {
        var data = PSIData()
        readings = json["items"][0]
        for (_, region) in json["region_metadata"] {
            if (region["name"].stringValue == RegionName.East.rawValue.lowercased()){
                data.east = self.loadRegion(region: region, regionName: RegionName.East)
            }
            if (region["name"].stringValue == RegionName.Central.rawValue.lowercased()){
                data.central = self.loadRegion(region: region, regionName: RegionName.Central)
            }
            if (region["name"].stringValue == RegionName.South.rawValue.lowercased()){
                data.south = self.loadRegion(region: region, regionName: RegionName.South)
            }
            if (region["name"].stringValue == RegionName.North.rawValue.lowercased()){
                data.north = self.loadRegion(region: region, regionName: RegionName.North)
            }
            if (region["name"].stringValue == RegionName.West.rawValue.lowercased()){
                data.west = self.loadRegion(region: region, regionName: RegionName.West)
            }
        }
        return data
    }
    
    func loadRegion(region:JSON, regionName:RegionName) -> PSIRegion?{
        return PSIRegion(name: regionName,
                         longitude: region["label_location"]["longitude"].double,
                         latitude: region["label_location"]["latitude"].double,
                         psi: readings["readings"]["psi_twenty_four_hourly"][regionName.rawValue.lowercased()].int)
    }
    
    func loadLocal() -> Any {
        if let path = Bundle.main.path(forResource: "psi", ofType: "json"){
            if let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path ))  {
                if let json = try? JSONSerialization.jsonObject(with: jsonData, options: []){
                    return json
                }
            }
        }
        return []
    }
}

