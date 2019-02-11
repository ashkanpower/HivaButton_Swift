//
//  UIViewHelper.swift
//  HivaButton
//
//  Created by Ashkan Ghodrat on 12/16/18.
//  Copyright © 2018 Ashkan Ghodrat. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setShadow(color : UIColor = UIColor.black, opacity : Float, height : CGFloat, width : CGFloat = 0, radius : CGFloat){
        
        self.clipsToBounds = false
        
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: width, height: height)
        layer.shadowRadius = radius
    }
}
