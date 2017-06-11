//
//  PSI.swift
//  HazeRadar
//
//  Created by Sajid Kalla on 11/6/17.
//  Copyright © 2017 Bytters. All rights reserved.
//

import Foundation
import SwiftyJSON


struct Settings {
    static let psiEndpoint = "https://api.data.gov.sg/v1/environment/psi"
    static let apiKey = "7n4g8nEYhzDDD0mwVuz0ctRH2sTWmoxd"
    static let apiKeyHeaderField = "api-key"
    static let dateTimeField = "date_time"
    static let dateFormat = "YYYY-MM-dd'T'HH:mm:ss"
}

class PSI{
    
    func load(date: Date, success: @escaping (PSIData) -> (), fail: @escaping (String?)-> ()) {
        var request = URLRequest(url:url(date: date))
        request.addValue(Settings.apiKey, forHTTPHeaderField: Settings.apiKeyHeaderField)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                fail(error?.localizedDescription)
            } else {
                if let psidata = data {
                    success(self.loadData(json: JSON(psidata)))
                }
            }
        }
        task.resume()
    }
    
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
    
    func url (date: Date) -> URL {
        let params = "\(Settings.dateTimeField)=\(formatDate(date: date).addingPercentEncoding (withAllowedCharacters: .urlHostAllowed)!)"
        let url = URL(string: "\(Settings.psiEndpoint)?\(params)")
        return url!
    }
    
    
    func formatDate (date:Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = Settings.dateFormat
        return formatter.string(from: date)
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


extension Int {
    var stringValue:String {
        return "\(self)"
    }
}

