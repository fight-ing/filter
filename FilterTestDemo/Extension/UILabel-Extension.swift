//
//  UILabel-Extension.swift
//  XiaoJuMa
//
//  Created by 刘飞 on 2020/10/26.
//

import Foundation

extension UILabel {
    convenience public init(font:UIFont,color:UIColor,alignment:NSTextAlignment = .left) {
        self.init()
        self.font = font
        self.textColor = color
        self.textAlignment = alignment
        
    }
}

extension String {
    func stringHeightWith(font:UIFont,width:CGFloat) -> CGFloat {
        
        let size = CGSize.init(width: width, height: CGFloat.greatestFiniteMagnitude)
//        let size = CGSizeMake(width,CGFloat.max)
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineBreakMode = .byWordWrapping;
        
        let attributes = [NSAttributedString.Key.font:font, NSAttributedString.Key.paragraphStyle:paragraphStyle.copy()]
        
        let text = self as NSString
        
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        
        return rect.size.height
    }
}

