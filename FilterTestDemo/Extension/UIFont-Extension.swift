//
//  UIFont-Extension.swift
//  XiaoJuMa
//
//  Created by 刘飞 on 2020/10/22.
//

import Foundation

extension UIFont {
    
    /// 快捷创建一个**Medium System Font**，因为UI使用此字体频率非常高
    /// - Parameter fontSize: 字体大小
    /// - Returns: UIFont对象
    public class func mediumFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight:UIFont.Weight.medium)
    }
    
    /// 快捷创建一个**Semibold System Font**，因为UI使用此字体频率非常高
    /// - Parameter fontSize: 字体大小
    /// - Returns: UIFont对象
    public class func semiboldFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight:UIFont.Weight.semibold)
    }
}


/// 快捷创建一个**Medium System Font**，因为UI使用此字体频率非常高
/// - Parameter fontSize: fontSize: 字体大小
/// - Returns: UIFont对象
public func MediumFont(_ fontSize: CGFloat) -> UIFont {
    return UIFont.mediumFont(ofSize: fontSize)
}

/// 快捷创建一个**Semibold System Font**，因为UI使用此字体频率非常高
/// - Parameter fontSize: 字体大小
/// - Returns: UIFont对象
public func SemiboldFont(_ fontSize: CGFloat) -> UIFont {
    return UIFont.semiboldFont(ofSize: fontSize)
}

/// 快捷创建一个**System Font**，因为UI使用此字体频率非常高
/// - Parameter fontSize: 字体大小
/// - Returns: UIFont对象
public func SystemFont(_ fontSize: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: fontSize)
}

/**
 *  创建一个平方字体
 */
public func ThemeMainTextFont(_ fontSize:CGFloat) -> UIFont {
    return UIFont.init(name: "PingFangSC-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
}

public func ThemeMainBoldTextFont(_ fontSize:CGFloat) ->UIFont {
    return UIFont.init(name: "PingFangTC-Semibold", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize)
}
