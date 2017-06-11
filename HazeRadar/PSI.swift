//
//  PSI.swift
//  HazeRadar
//
//  Created by Sajid Kalla on 11/6/17.
//  Copyright © 2017 Bytters. All rights reserved.
//

import Foundation



class PSI{
    
    func load() {
        print(self.loadLocal())
    }
    
    
    func loadLocal() -> Any? {
        if let path = Bundle.main.path(forResource: "psi", ofType: "json"){
            if let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path ))  {
                if let json = try? JSONSerialization.jsonObject(with: jsonData, options: []){
                    return json
                }
            }
        }
        return nil
    }
}

