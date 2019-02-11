//
//  Constraints.swift
//  Batab
//
//  Created by Ashkan Ghodrat on 1/20/19.
//  Copyright © 2019 Ashkan Ghodrat. All rights reserved.
//

import Foundation
import UIKit

class ConstraitHolder {
    
    enum SafeType {
        case normal
        case safe
    }
    
    enum Anchor {
        
        case leading
        case trailing
        case top
        case topSafe
        case bottom
        case bottomSafe
        case centerX
        case centerY
        case width
        case height
        case ascpectRatio
        case allEdge
        case sameSize
        case center
    }
    
    enum SetType {
        case equal
        case greater
        case less
    }
    
    var view : UIView!
    var toView : UIView!
    
    fileprivate var leading : NSLayoutConstraint?
    fileprivate var trailing : NSLayoutConstraint?
    fileprivate var top : NSLayoutConstraint?
    fileprivate var bottom : NSLayoutConstraint?
    
    fileprivate var width : NSLayoutConstraint?
    fileprivate var height : NSLayoutConstraint?
    
    fileprivate var centerX : NSLayoutConstraint?
    fileprivate var centerY : NSLayoutConstraint?
    
    fileprivate var aspectRatio : NSLayoutConstraint?
    
    
    init(_ view : UIView){
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view = view
    }
    
    func to(_ view : UIView) -> ConstraitHolder {
        self.toView = view
        return self
    }
    
    @discardableResult
    func set(_ first : Anchor, _ second : Anchor, _ constant : CGFloat = 0, _ prioarity : UILayoutPriority = .defaultHigh) -> ConstraitHolder {
        
        
        switch first {
            
        case .leading:
            if let found = findConstraint(first, toView){
                leading = found
                found.constant = constant
            }else{
                leading = view.leadingAnchor.constraint(equalTo: getAnchor(toView, second), constant: constant)
                leading?.priority = prioarity
                leading?.isActive = true
            }
        case .trailing:
            if let found = findConstraint(first, toView){
                trailing = found
                found.constant = constant
            }else{
                trailing = view.trailingAnchor.constraint(equalTo: getAnchor(toView, second), constant: -constant)
                trailing?.priority = prioarity
                trailing?.isActive = true
            }
        case .top:
            if let found = findConstraint(first, toView){
                top = found
                found.constant = constant
            }else{
                top = view.topAnchor.constraint(equalTo: getAnchor(toView, second), constant: constant)
                top?.priority = prioarity
                top?.isActive = true
            }
        case .bottom:
            if let found = findConstraint(first, toView){
                bottom = found
                found.constant = constant
            }else{
                bottom = view.bottomAnchor.constraint(equalTo: getAnchor(toView, second), constant: -constant)
                bottom?.priority = prioarity
                bottom?.isActive = true
            }
        case .width:
            if let found = findConstraint(first, toView){
                width = found
                found.constant = constant
            }else{
                width = view.widthAnchor.constraint(equalTo: getAnchor(toView, second), constant: constant)
                width?.priority = prioarity
                width?.isActive = true
            }
        case .height:
            if let found = findConstraint(first, toView){
                height = found
                found.constant = constant
            }else{
                height = view.heightAnchor.constraint(equalTo: getAnchor(toView, second), constant: constant)
                height?.priority = prioarity
                height?.isActive = true
            }
        default:
            fatalError("First anchor doesnt need another anchor")
        }
        
        return self
    }
    
    @discardableResult
    func set(_ anchor : Anchor, _ constant : CGFloat = 0, _ prioarity : UILayoutPriority = .defaultHigh) -> ConstraitHolder {
        
        switch anchor {
            
        case .leading:
            if let found = findConstraint(anchor, nil){
                leading = found
                found.constant = constant
            }else{
                leading = view.leadingAnchor.constraint(equalTo: getAnchor(toView, .leading), constant: constant)
                leading?.priority = prioarity
                leading?.isActive = true
            }
        case .trailing:
            if let found = findConstraint(anchor, nil){
                trailing = found
                found.constant = constant
            }else{
                trailing = view.trailingAnchor.constraint(equalTo: getAnchor(toView, .trailing), constant: -constant)
                trailing?.priority = prioarity
                trailing?.isActive = true
            }
        case .top:
            if let found = findConstraint(anchor, nil){
                top = found
                found.constant = constant
            }else{
                top = view.topAnchor.constraint(equalTo: getAnchor(toView, .top), constant: constant)
                top?.priority = prioarity
                top?.isActive = true
            }
        case .bottom:
            if let found = findConstraint(anchor, nil){
                bottom = found
                found.constant = constant
            }else{
                bottom = view.bottomAnchor.constraint(equalTo: getAnchor(toView, .bottom), constant: -constant)
                bottom?.priority = prioarity
                bottom?.isActive = true
            }
        case .width:
            if let found = findConstraint(anchor, nil){
                width = found
                found.constant = constant
            }else{
                width = view.widthAnchor.constraint(equalToConstant: constant)
                width?.priority = prioarity
                width?.isActive = true
            }
        case .height:
            
            if let found = findConstraint(anchor, nil){
                height = found
                found.constant = constant
            }else{
                height = view.heightAnchor.constraint(equalToConstant: constant)
                height?.priority = prioarity
                height?.isActive = true
            }
        case .centerX:
            if let found = findConstraint(anchor, nil){
                centerX = found
                found.constant = constant
            }else{
                centerX = view.centerXAnchor.constraint(equalTo: getAnchor(toView, .centerX), constant: constant)
                centerX?.priority = prioarity
                centerX?.isActive = true
            }
        case .centerY:
            if let found = findConstraint(anchor, nil){
                centerY = found
                found.constant = constant
            }else{
                centerY = view.centerYAnchor.constraint(equalTo: getAnchor(toView, .centerY), constant: constant)
                centerY?.priority = prioarity
                centerY?.isActive = true
            }
        case .allEdge:
            set(.top, .top, constant)
            set(.bottom, .bottom, constant)
            set(.trailing, .trailing, constant)
            set(.leading, .leading, constant)
        case .sameSize:
            set(.width, .width, constant)
            set(.height,.height, constant)
        case .center :
            set(.centerX, constant)
            set(.centerY, constant)
        case .ascpectRatio:
            
            if let found = findConstraint(anchor, nil){
                view.removeConstraint(found)
            }
            
            aspectRatio = view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: constant, constant: 0)
            height = aspectRatio
            height?.priority = prioarity
            height?.isActive = true
            
        default :
            fatalError("cannot connect constraints")
        }
        
        return self
    }
    
    func findConstraint(_ anchor : Anchor, _ toView : UIView? = nil) -> NSLayoutConstraint? {
        
        
        for con in view.superview?.constraints ?? [] {
            if (con.firstItem as? UIView) == view {
                
                if con.firstAttribute == convertAnchorToAttribute(anchor){
                    return con
                }
            }
            if(con.secondItem as? UIView) == view {
                
                if con.secondAttribute == convertAnchorToAttribute(anchor){
                    return con
                }
            }
        }
        
        for con in view.constraints {
            if (con.firstItem as? UIView) == view && (toView == nil || (con.secondItem as? UIView) == toView) {
                
                if con.firstAttribute == convertAnchorToAttribute(anchor) {
                    return con
                }
            }
        }
        
        return nil
    }
    
    private func setAnchor(_ anchor : NSLayoutXAxisAnchor, to : NSLayoutXAxisAnchor, toAnchor : Anchor, type : SetType, constant : CGFloat) -> NSLayoutConstraint {
        
        switch type {
        case .equal:
            return anchor.constraint(equalTo: to, constant: constant)
        case .greater:
            return anchor.constraint(greaterThanOrEqualTo: to, constant: constant)
        case .less:
            return anchor.constraint(lessThanOrEqualTo: to, constant: constant)
        }
    }
    
    private func setAnchor(_ anchor : NSLayoutYAxisAnchor, to : NSLayoutYAxisAnchor, toAnchor : Anchor, type : SetType, constant : CGFloat) -> NSLayoutConstraint {
        
        switch type {
        case .equal:
            return anchor.constraint(equalTo: to, constant: constant)
        case .greater:
            return anchor.constraint(greaterThanOrEqualTo: to, constant: constant)
        case .less:
            return anchor.constraint(lessThanOrEqualTo: to, constant: constant)
        }
    }
    
    private func setAnchor(_ anchor : NSLayoutDimension, to : NSLayoutDimension, toAnchor : Anchor, type : SetType, constant : CGFloat) -> NSLayoutConstraint {
        
        switch type {
        case .equal:
            return anchor.constraint(equalTo: to, constant: constant)
        case .greater:
            return anchor.constraint(greaterThanOrEqualTo: to, constant: constant)
        case .less:
            return anchor.constraint(lessThanOrEqualTo: to, constant: constant)
        }
    }
    
    private func getAnchor(_ view : UIView, _ anchor : Anchor) -> NSLayoutXAxisAnchor {
        switch anchor {
            
        case .leading:
            return view.leadingAnchor
        case .trailing:
            return view.trailingAnchor
        case .centerX:
            return view.centerXAnchor
            
        default :
            fatalError("cannot connect constraints")
        }
    }
    
    private func getAnchor(_ view : UIView, _ anchor : Anchor) -> NSLayoutYAxisAnchor {
        switch anchor {
            
        case .top:
            return view.topAnchor
        case .topSafe:
            if #available(iOS 11, *) {
                return view.safeAreaLayoutGuide.topAnchor
            } else {
                return view.topAnchor
            }
        case .bottom:
            return view.bottomAnchor
        case .bottomSafe:
            
            if #available(iOS 11, *) {
                return view.safeAreaLayoutGuide.bottomAnchor
            } else {
                return view.bottomAnchor
            }
        case .centerY:
            return view.centerYAnchor
        default :
            fatalError("cannot connect constraints")
        }
    }
    
    private func getAnchor(_ view : UIView, _ anchor : Anchor) -> NSLayoutDimension {
        switch anchor {
            
        case .width:
            return view.widthAnchor
        case .height:
            return view.heightAnchor
        default :
            fatalError("cannot connect constraints")
        }
    }
    
    
    private func convertAnchorToAttribute(_ anchor : Anchor) -> NSLayoutConstraint.Attribute {
        switch anchor {
            
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        case .top:
            return .top
        case .topSafe:
            return .topMargin
        case .bottom:
            return .bottom
        case .bottomSafe:
            return .bottomMargin
        case .centerX:
            return .centerX
        case .centerY:
            return .centerY
        case .width:
            return .width
        case .height:
            return .height
        case .ascpectRatio:
            return .height
        case .allEdge:
            return .notAnAttribute
        case .sameSize:
            return .notAnAttribute
        case .center:
            return .notAnAttribute
        }
    }
}

extension UIView {
    
    func constraint(to : UIView) -> ConstraitHolder {
        return ConstraitHolder(self).to(to)
    }
}
