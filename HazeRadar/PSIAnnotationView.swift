//
//  PSIAnnotationView.swift
//  HazeRadar
//
//  Created by Sajid Kalla on 11/6/17.
//  Copyright © 2017 Bytters. All rights reserved.
//

import UIKit
import MapKit

class PSIAnnotationView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        if let psiAnnotation = annotation as? PSIAnnotation{
            
            let displayText = self.getAttributedString(annotation: psiAnnotation)
            let height:CGFloat = 60
            let width = displayText.width(withConstrainedHeight: height)
            
            let label: UILabel! = UILabel()
            label.attributedText = displayText
            label.numberOfLines = 0
            label.backgroundColor = UIColor.red.withAlphaComponent(0.4)
            label.layer.borderColor = UIColor.red.cgColor
            label.layer.borderWidth = 1
            label.layer.cornerRadius = 3
            label.textAlignment = NSTextAlignment.center
            
            label.frame = CGRect(x: -(width/2), y: -(height/2), width: (width * 1.2), height: height)
            
            
            self.addSubview(label)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func getAttributedString (annotation: PSIAnnotation) -> NSMutableAttributedString{
        
        let regionAttributes: [String: AnyObject] = [NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: UIFontWeightLight),
                                                     NSForegroundColorAttributeName: UIColor.white]
        let psiAttributes: [String: AnyObject] = [NSFontAttributeName: UIFont.systemFont(ofSize: 22, weight: UIFontWeightHeavy),
                                                  NSForegroundColorAttributeName: UIColor.white]
        
        let region = NSMutableAttributedString(string: "\(annotation.subtitle!.uppercased())\n", attributes: regionAttributes)
        let psi = NSMutableAttributedString(string: annotation.title!, attributes: psiAttributes)
        
        region.append(psi)
        return region
        
    }
    
}


extension NSMutableAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.height
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.width
    }
}
