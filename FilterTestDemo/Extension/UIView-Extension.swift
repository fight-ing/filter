//
//  UIView-Extension.swift
//  XiaoJuMa
//
//  Created by 刘飞 on 2020/10/26.
//

import Foundation


extension UIView {
    
    /// x origin of view.
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    /// y origin of view.
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    /// Width of view.
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    /// Height of view.
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    /// Size of view.
    var size: CGSize {
        get {
            return frame.size
        }
        set {
            frame.size = newValue
        }
    }
    
    /// Origin of view.
    var origin: CGPoint {
        get {
            return frame.origin
        }
        set {
            frame.origin = newValue
        }
    }
    
    /// CenterX of view.
    var centerX: CGFloat {
        get {
            return center.x
        }
        set {
            center.x = newValue
        }
    }
    
    /// CenterY of view.
    var centerY: CGFloat {
        get {
            return center.y
        }
        set {
            center.y = newValue
        }
    }
    
    /// Bottom of view.
    var bottom: CGFloat {
        return frame.maxY
    }
    
    
    
    // MARK: - 设置圆角
    func setViewBorder(cornerRadius:CGFloat = 3, color:UIColor) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = color.cgColor;
        self.layer.borderWidth = 1;
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = self.layer.contentsScale
    }
    
    func setViewBorderWidth(_ borderWidth:CGFloat = 1, _ borderColor:UIColor) {
        self.layer.borderColor = borderColor.cgColor;
        self.layer.borderWidth = borderWidth;
    }
    
    // MARK: - 设置阴影
    func setViewShadowColor(shadowOpacity:Float,shadowColor:UIColor,shadowOffset:CGSize) {
        
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffset
    }
    
    /// 设置单独某个位置圆角
    ///
    /// - Parameters:
    ///   - make: 圆角范围
    ///   - corners: 设置圆角位置
    /// - Returns: CAShapeLayer
    class func changeMaskLayer(rect:CGRect ,make: CGSize, corners: UIRectCorner) -> CAShapeLayer {
        let maskPath = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: make)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = rect
        maskLayer.path = maskPath.cgPath
        return maskLayer
    }
    
    
    /// 在view中获取view所在控制器
    ///
    /// - Returns: UIViewController
    func setViewController() -> UIViewController? {
        var next:UIView? = self
        repeat{
            if let nextResponder = next?.next {
                if nextResponder.isKind(of: UIViewController.self) {
                    return (nextResponder as! UIViewController)
                }
            }
            next = next?.superview
        }while next != nil
        return nil
    }
}

