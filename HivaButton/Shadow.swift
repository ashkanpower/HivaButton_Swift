
//
//  ShadowHelper.swift
//  Batab
//
//  Created by Ashkan Ghodrat on 1/20/19.
//  Copyright © 2019 Ashkan Ghodrat. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    func setShadow(color : UIColor = UIColor.black, opacity : Float, height : CGFloat, width : CGFloat = 0, radius : Float){
        
        self.clipsToBounds = false
        
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: width, height: height)
        layer.shadowRadius = CGFloat(radius)
    }
    
    
    func setCardShadow(opacity : Float = 0.15){
        
        self.clipsToBounds = false
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 10
    }
    
    func setCardShadowBig(){
        
        self.clipsToBounds = false
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 3
        
    }
    
    func setCardShadowPanel(){
        
        self.clipsToBounds = false
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 3
        
    }
    
    func removeCardShadow(){
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOpacity = 0
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 0
    }
}
