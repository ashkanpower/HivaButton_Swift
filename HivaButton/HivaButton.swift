//
//  HivaButton.swift
//  HivaButton
//
//  Created by Ashkan Ghodrat on 12/12/18.
//  Copyright © 2018 Ashkan Ghodrat. All rights reserved.
//

import Foundation
import UIKit

fileprivate enum Type {
    case horizontal
    case vertical
}

@IBDesignable
class HivaButton : UIControl {
    
    fileprivate var buttonType : Type {
        get {
            return .horizontal
        }
    }
    
    typealias ClickListener = (() -> Void)
    typealias ToggleListener = (() -> Void)
    
    @IBInspectable var text: String = "" {
        didSet {
            self.label.text = text
        }
    }
    
    @IBInspectable var icon: UIImage? {
        didSet {
            setAllProperties()
        }
    }
    
    @IBInspectable var offIcon: UIImage? {
        didSet {
            setAllProperties()
        }
    }
    
    @IBInspectable var grayIndicator: Bool = true {
        didSet {
            self.indicator.style = grayIndicator ? .gray : .white
        }
    }
    
    
    @IBInspectable var fontSize: CGFloat = CGFloat(14) {
        didSet {
            self.label.font = self.label.font.withSize(fontSize)
            setAllProperties()
        }
    }
    
    @IBInspectable var iconBox: CGFloat = 20 {
        didSet {
            
            setAllProperties()
        }
    }
    
    @IBInspectable var iconBoxWidth: CGFloat = CGFloat.leastNormalMagnitude {
        didSet {
            setAllProperties()
        }
    }
    
    @IBInspectable var space: CGFloat = 8 {
        didSet {
            //self.stackView.spacing = space
            self.spaceConstraint.constant = space
        }
    }
    
    @IBInspectable var widthPadding: CGFloat = 16 {
        didSet {
            
            setAllProperties()
        }
    }
    
    @IBInspectable var heightPadding: CGFloat = 16 {
        didSet {
            
            setAllProperties()
        }
    }
    
    @IBInspectable var isCenter: Bool = true {
        didSet {
            
            setAllProperties()
        }
    }
 
    @IBInspectable var textColor: UIColor = UIColor.darkGray {
        didSet {
            
            setAllProperties()
        }
    }
    
    @IBInspectable var iconColor: UIColor? {
        didSet {
            
            setAllProperties()
        }
    }
    
    @IBInspectable var backColor: UIColor? {
        didSet {
            setAllProperties()
        }
    }
    
    
    fileprivate var _cornerRadius = CGFloat(0)
    @IBInspectable var cornerRaduis: CGFloat = 8 {
        
        didSet {
            setCornerRadius()
        }
    }
    
    @IBInspectable var roundCorner : Bool = false {
        didSet {
            setCornerRadius()
        }
    }
    
    private func setCornerRadius(){
        
        if roundCorner {
            _cornerRadius = self.frame.height / 2
        }else{
            _cornerRadius = cornerRaduis
        }
        
        self.backView.layer.cornerRadius = _cornerRadius
        setGradient()
    }
    
    
    @IBInspectable var borderColor: UIColor? { didSet { setAllProperties() } }
    
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            self.backView.layer.borderColor = borderColor == nil ? UIColor.white.withAlphaComponent(0).cgColor : borderColor?.cgColor
            self.backView.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var textTouchColor: UIColor? { didSet { setAllProperties() } }
    @IBInspectable var iconTouchColor: UIColor? { didSet { setAllProperties() } }
    @IBInspectable var backTouchColor: UIColor? { didSet { setAllProperties() } }
    @IBInspectable var borderTouchColor: UIColor? { didSet { setAllProperties() } }
    
    @IBInspectable var textDisabledColor: UIColor? { didSet { setAllProperties() } }
    @IBInspectable var iconDisabledColor: UIColor? { didSet { setAllProperties() } }
    @IBInspectable var backDisabledColor: UIColor? { didSet { setAllProperties() } }
    @IBInspectable var borderDisabledColor: UIColor? { didSet { setAllProperties() } }
    
    
    @IBInspectable var isToggle : Bool = false
    
    @IBInspectable var isOn : Bool = false {
        didSet {
            setAllProperties()
        }
    }
    
    @IBInspectable var shadowColor: UIColor? { didSet { setShadow() } }
    @IBInspectable var shadowX: CGFloat = 0 { didSet { setShadow() } }
    @IBInspectable var shadowY: CGFloat = 1 { didSet { setShadow() } }
    @IBInspectable var shadowRadius: CGFloat = 2 { didSet { setShadow() } }
    
    
    @IBInspectable var gradientFirstColor: UIColor? { didSet {  setGradient() } }
    @IBInspectable var gradientSecondColor: UIColor? { didSet { setGradient() } }
    @IBInspectable var gradientAngle: Int = 0 { didSet { setGradient() } }
    // @IBInspectable var shadowRadius: CGFloat = 2 { didSet { setShadow() } }
    
    @IBInspectable var isBackward : Bool = false {
        didSet {
            
            if isBackward && buttonType == .horizontal {
                self.stackView.transform = self.stackView.transform.scaledBy(x: -1, y: 1)
                self.label.transform = self.label.transform.scaledBy(x: -1, y: 1)
                self.imageView.transform = self.imageView.transform.scaledBy(x: -1, y: 1)
            }else if isBackward && buttonType == .vertical {
                
                self.stackView.transform = self.stackView.transform.scaledBy(x: 1, y: -1)
                self.label.transform = self.label.transform.scaledBy(x: 1, y: -1)
                self.imageView.transform = self.imageView.transform.scaledBy(x: 1, y: -1)
            }else{
                
                self.stackView.transform = .identity
                self.label.transform = .identity
                self.imageView.transform = .identity
            }
            
        }
    }
    
    
    fileprivate func setIcon(){
        
        if isLoading {
            self.imageView.image = nil
            return
        }
        
        if isToggle && !isOn {
            self.imageView.image = offIcon ?? icon
        }else{
            self.imageView.image = icon
        }
    }
    
    fileprivate func setIconColor(color : UIColor?){
        
        if color == nil || color == .clear{
            if self.imageView.image?.renderingMode != .alwaysOriginal {
                self.imageView.image = imageView.image?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            }
        }else{
            self.imageView.tintColor = color
            if self.imageView.image?.renderingMode != .alwaysTemplate {
                self.imageView.image = imageView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            }
        }
    }
    
    fileprivate func setIconColor(){
        
        if !isEnabled {
            setIconColor(color: iconDisabledColor ?? iconColor ?? textDisabledColor ?? textColor)
            return
        }
        
        if isToggle && !isOn{
            
            setIconColor(color: iconTouchColor ?? textTouchColor ?? iconColor ?? textColor)
            return
        }
        
        setIconColor(color: iconColor ?? textColor)
    }
    
    fileprivate func setTextColor(){
        
        if !isEnabled {
            self.label.textColor = textDisabledColor ?? textColor
            return
        }
        
        if isToggle && !isOn{
            
            self.label.textColor = textTouchColor
            return
        }
        
        self.label.textColor = textColor
    }
    
    fileprivate func setBackColor(){
        
        if !isEnabled {
            self.backView.backgroundColor = backDisabledColor ?? backColor
            return
        }
        
        if isToggle && !isOn{
            
            self.backView.backgroundColor = backTouchColor ?? backColor
            return
        }
        
        self.backView.backgroundColor = backColor
    }
    
    fileprivate func setBorderColor(){
        
        if !isEnabled {
            self.backView.layer.borderColor = borderDisabledColor == nil ? (borderColor == nil ? UIColor.white.withAlphaComponent(0).cgColor : borderColor?.cgColor) : borderDisabledColor?.cgColor
            return
        }
        
        if isToggle && !isOn{
            
            let borderOnColor = borderTouchColor ?? borderColor ?? UIColor.white.withAlphaComponent(0)
            self.backView.layer.borderColor = borderOnColor.cgColor
            return
        }
        
        self.backView.layer.borderColor = borderColor == nil ? UIColor.white.withAlphaComponent(0).cgColor : borderColor?.cgColor
    }
    
    private func setAllProperties(){
        
        self.setIcon()
        self.setIconColor()
        
        self.iconHeightConstraint.constant = iconBox
        if iconBoxWidth == CGFloat.leastNormalMagnitude {
            self.iconWidthConstraint.constant = iconBox
        }else{
            self.iconWidthConstraint.constant = iconBoxWidth
        }

        
        self.leftConstraint.constant = widthPadding
        self.rightConstraint.constant = widthPadding
        
        self.topConstraint.constant = heightPadding
        self.bottomConstraint.constant = heightPadding
        
        
        self.setTextColor()
        self.setBackColor()
        self.setBorderColor()
        
        self.setCornerRadius()
        self.setGradient()
        
        if isCenter {
            spaceConstraint.isActive = true
        }else{
            spaceConstraint.isActive = false
        }
        
        if fontSize == 0 {
            label.isHidden = true
        }else{
            label.isHidden = false
        }
        
        if iconBox == 0 {
            imageView.isHidden = true
        }else{
            imageView.isHidden = false
        }
                
        self.layoutIfNeeded()
    }
    
    
    private func setShadow(){
        
        self.setShadow(color: shadowColor ?? .clear, opacity: 1, height: shadowY, width: shadowX, radius: shadowRadius)
    }
    
    var gradient: CAGradientLayer?
    
    private func setGradient(){
        
        if gradient != nil{
            gradient?.removeFromSuperlayer()
        }
        gradient = CAGradientLayer()
        gradient?.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        self.gradientView.layer.insertSublayer(gradient!, at: 0)
        
        
        if gradientFirstColor == nil || gradientSecondColor == nil {
            return
        }
        
        gradient?.colors = [gradientFirstColor!.cgColor, gradientSecondColor!.cgColor]
        gradient?.locations = [0.0 , 1.0]
        gradient?.calculatePoints(for: gradientAngle)
        gradient?.cornerRadius = _cornerRadius
        
    }
    
    
    var font: UIFont? {
        didSet {
            self.label.font = font
        }
    }
    
    func startLoading() {
        
        self.isUserInteractionEnabled = false
        indicator.isHidden = false
        indicator.startAnimating()
        isLoading = true
        self.setIcon()

    }
    
    func stopLoading() {
        
        isLoading = false
        self.isUserInteractionEnabled = true
        self.setIcon()
        self.setIconColor()
        indicator.isHidden = true
    }
    
    var view: UIView!
    @IBOutlet var backView : UIView!
    @IBOutlet var gradientView : UIView!
    @IBOutlet var stackView : UIView!
    @IBOutlet var label : UILabel!
    @IBOutlet var imageView : UIImageView!
    @IBOutlet var indicator : UIActivityIndicatorView!
    @IBOutlet var iconHeightConstraint : NSLayoutConstraint!
    @IBOutlet var iconWidthConstraint : NSLayoutConstraint!
    @IBOutlet var leftConstraint : NSLayoutConstraint!
    @IBOutlet var rightConstraint : NSLayoutConstraint!
    @IBOutlet var topConstraint : NSLayoutConstraint!
    @IBOutlet var bottomConstraint : NSLayoutConstraint!
    @IBOutlet var centerXConstraint : NSLayoutConstraint!
    @IBOutlet var centerYConstraint : NSLayoutConstraint!
    @IBOutlet var spaceConstraint : NSLayoutConstraint!
    
    var isLoading = false
    
    //listeners
    fileprivate var clickListeners : [ClickListener] = []
    fileprivate var toggleListeners : [ToggleListener] = []
    
    func clickListener(_ callback : @escaping(ClickListener)){
        self.clickListeners.append(callback)
    }
    
    func toggleListener(_ callback : @escaping(ToggleListener)){
        self.toggleListeners.append(callback)
    }
    
    fileprivate func invokeClickListener(){
        for listener in clickListeners {
            listener()
        }
    }
    
    fileprivate func invokeToggleListener(){
        for listener in toggleListeners {
            listener()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
        
        initView()
    }
    
    
    private func initView(){
        
        backgroundColor = UIColor.clear
        view = loadNib()
        view.backgroundColor = UIColor.clear
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Adding custom subview on top of our view
        addSubview(view)

        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.layer.zPosition = -1
        
        indicator.isHidden = true
        grayIndicator = true

        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.someAction(_:)))
        view.addGestureRecognizer(gesture)
        
    }
    
    
    override func layoutSubviews() {
        self.view.frame = bounds
        setAllProperties()
    }
    
    @IBInspectable var enableAtFirst: Bool = true {
        didSet {
            self.isEnabled = enableAtFirst
            self.setAllProperties()
            
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            self.setAllProperties()
        }
    }
    
    override func didMoveToSuperview() {
        self.setAllProperties()
    }
    
    @objc func someAction(_ sender:UITapGestureRecognizer){
        
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.highlight()
        }, completion: { (Bool) -> Void in
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.unhighlight()
            })
        });
        
        isOn = !isOn
        self.invokeClickListener()
        self.invokeToggleListener()
        self.sendActions(for: .touchUpInside)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.highlight()
        });
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let loc = touches.first!.location(in: self.superview)
        let extendedFrame = self.frame.insetBy(dx: -(40), dy: -(40))
        
        if !extendedFrame.contains(loc) {
            
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.unhighlight()
            });
        }
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.unhighlight()
        });
        
        let loc = touches.first!.location(in: self.superview)
        
        if self.frame.contains(loc) {
            isOn = !isOn
            self.invokeClickListener()
            self.invokeToggleListener()
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.unhighlight()
        })
    }
    
    func highlight(){
        
        if isToggle {
            return
        }
        
        if self.textTouchColor != nil {
            self.label.textColor = self.textTouchColor
        }
        
        if self.iconTouchColor != nil {
            self.setIconColor(color: self.iconTouchColor)
        }else if self.textTouchColor != nil && self.iconColor == nil {
            self.setIconColor(color: self.textTouchColor)
        }
        
        if self.borderTouchColor != nil {
            self.backView.layer.borderColor = borderTouchColor?.cgColor
        }
        
        if self.backTouchColor != nil {
            self.backView.backgroundColor = self.backTouchColor
        }
        
        
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        for subview in self.subviews  {
            if subview.hitTest(point, with: event) != nil  {
                return true
            }
        }
        
        return false
    }
    
    func unhighlight(){
        
        if isToggle {
            return
        }
        
        setAllProperties()
    }
    
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}

@IBDesignable
class HivaButtonVertical : HivaButton {
    
    fileprivate override var buttonType : Type {
        get {
            return .vertical
        }
    }
    
}

extension UIView {
    func setShadow(color : UIColor = UIColor.black, opacity : Float, height : CGFloat, width : CGFloat = 0, radius : CGFloat){
        
        self.clipsToBounds = false
        
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: width, height: height)
        layer.shadowRadius = radius
    }
}



//
//  HivaButton
//
public extension CAGradientLayer {
    
    /// Sets the start and end points on a gradient layer for a given angle.
    ///
    /// - Important:
    /// *0°* is a horizontal gradient from left to right.
    ///
    /// With a positive input, the rotational direction is clockwise.
    ///
    ///    * An input of *400°* will have the same output as an input of *40°*
    ///
    /// With a negative input, the rotational direction is clockwise.
    ///
    ///    * An input of *-15°* will have the same output as *345°*
    ///
    /// - Parameters:
    ///     - angle: The angle of the gradient.
    ///
    public func calculatePoints(for angle: CGFloat) {
        
        
        var ang = (-angle).truncatingRemainder(dividingBy: 360)
        
        if ang < 0 { ang = 360 + ang }
        
        let n: CGFloat = 0.5
        
        switch ang {
            
        case 0...45, 315...360:
            let a = CGPoint(x: 0, y: n * tanx(ang) + n)
            let b = CGPoint(x: 1, y: n * tanx(-ang) + n)
            startPoint = a
            endPoint = b
            
        case 45...135:
            let a = CGPoint(x: n * tanx(ang - 90) + n, y: 1)
            let b = CGPoint(x: n * tanx(-ang - 90) + n, y: 0)
            startPoint = a
            endPoint = b
            
        case 135...225:
            let a = CGPoint(x: 1, y: n * tanx(-ang) + n)
            let b = CGPoint(x: 0, y: n * tanx(ang) + n)
            startPoint = a
            endPoint = b
            
        case 225...315:
            let a = CGPoint(x: n * tanx(-ang - 90) + n, y: 0)
            let b = CGPoint(x: n * tanx(ang - 90) + n, y: 1)
            startPoint = a
            endPoint = b
            
        default:
            let a = CGPoint(x: 0, y: n)
            let b = CGPoint(x: 1, y: n)
            startPoint = a
            endPoint = b
            
        }
    }
    
    /// Private function to aid with the math when calculating the gradient angle
    private func tanx(_ 𝜽: CGFloat) -> CGFloat {
        return tan(𝜽 * CGFloat.pi / 180)
    }
    
    
    // Overloads
    
    /// Sets the start and end points on a gradient layer for a given angle.
    public func calculatePoints(for angle: Int) {
        calculatePoints(for: CGFloat(angle))
    }
    
    /// Sets the start and end points on a gradient layer for a given angle.
    public func calculatePoints(for angle: Float) {
        calculatePoints(for: CGFloat(angle))
    }
    
    /// Sets the start and end points on a gradient layer for a given angle.
    public func calculatePoints(for angle: Double) {
        calculatePoints(for: CGFloat(angle))
    }
    
}

extension CGFloat {
    
    var radian : CGFloat {
        get {
            return self * CGFloat.pi / 180
        }
    }
}
