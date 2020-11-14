//
//  UIButton-Extension.swift
//  XiaoJuMa
//
//  Created by 刘飞 on 2020/10/29.
//

import Foundation

enum CButtonImagePosition {

    case top
    case bottom
    case left
    case right
}

extension UIButton{
    
    
    
// 待定
    func buttonImagePosition(position:CButtonImagePosition = .left, spacing:CGFloat)  {
        
        let imageWidth = self.imageView?.frame.size.width
       let imageHeight = self.imageView?.frame.size.height
       
       var labelWidth: CGFloat! = 0.0
       var labelHeight: CGFloat! = 0.0
       
       labelWidth = self.titleLabel?.intrinsicContentSize.width
       labelHeight = self.titleLabel?.intrinsicContentSize.height
        //初始化imageEdgeInsets和labelEdgeInsets
       var imageEdgeInsets = UIEdgeInsets.zero
       var labelEdgeInsets = UIEdgeInsets.zero
        
        //根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch position {
        case .top:
            //上 左 下 右
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight-spacing/2, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom: -imageHeight!-spacing/2, right: 0)
            break;
            
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
            break;
            
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight!-spacing/2, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight!-spacing/2, left: -imageWidth!, bottom: 0, right: 0)
            break;
            
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+spacing/2, bottom: 0, right: -labelWidth-spacing/2)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!-spacing/2, bottom: 0, right: imageWidth!+spacing/2)
            break;
            
        }
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets

    }
    
}

