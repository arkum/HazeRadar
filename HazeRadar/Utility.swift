//
//  Utility.swift
//  HazeRadar
//
//  Created by Sajid Kalla on 11/6/17.
//  Copyright © 2017 Bytters. All rights reserved.
//

import Foundation
import UIKit

class Utility: NSObject {
    static func roundEdgeWithShadow(view:UIView, radius:CGFloat){
        view.layer.cornerRadius = radius;
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 1.5;
        view.layer.shadowOpacity = 0.6;
        view.layer.shadowOffset = CGSize(width: 0, height: 0.8)
    }
    
}
