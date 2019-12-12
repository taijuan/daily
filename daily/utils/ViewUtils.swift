//
//  ViewUtils.swift
//  daily
//
//  Created by 郑泰捐 on 2019/11/25.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

extension UIView {
    //MARK:设置UIVIew，UIImageView等的边框，圆角，阴影
    func setViewShadow(
        borderWidth:CGFloat = 1,//边框宽度
        borderColor:UIColor = UIColor.lightGray,//边框颜色
        cornerRadius : CGFloat = 4,//圆角半径
        shadowColor:UIColor = UIColor.lightGray,//阴影颜色
        shadowOffset:CGSize = CGSize(width: 8, height: 8),//隐隐偏移量
        shadowRadius:CGFloat = 8//边框圆角和阴影半径
        ) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = shadowOffset
        self.layer.masksToBounds = true
    }
    
    //MARK:设置UIView渐变背景
    func setGradientLayer(startColor:UIColor,endColor:UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        self.layer.addSublayer(gradientLayer)
    }
    
    //MARK:单独设置圆角
    func setMutiBorderRoundingCorners(_ view:UIView,corner:CGFloat){
        let maskPath = UIBezierPath.init(roundedRect: view.bounds,
        byRoundingCorners: [UIRectCorner.bottomLeft, UIRectCorner.topRight],
        cornerRadii: CGSize(width: corner, height: corner))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.path = maskPath.cgPath
        view.layer.mask = maskLayer
    }
    
    //MARK:单独设置border
    func setBorderWithView(_ view:UIView,top:Bool,left:Bool,bottom:Bool,right:Bool,width:CGFloat,color:UIColor){
        if top {
            let layer = CALayer()
            layer.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: width)
            layer.backgroundColor = color.cgColor
            view.layer.addSublayer(layer)
        }
        if left {
            let layer = CALayer()
            layer.frame = CGRect(x: 0, y: 0, width: width, height: view.frame.size.height)
            layer.backgroundColor = color.cgColor
            view.layer.addSublayer(layer)
        }

        if bottom {
            let layer = CALayer()
            layer.frame = CGRect(x: 0, y: view.frame.size.height - width, width: width, height: width)
            layer.backgroundColor = color.cgColor
            view.layer.addSublayer(layer)
        }
        if right {
            let layer = CALayer()
            layer.frame = CGRect(x: view.frame.size.width - width, y: 0, width: width, height: view.frame.size.height)
            layer.backgroundColor = color.cgColor
            view.layer.addSublayer(layer)
        }
    }

}

extension UIButton {
    //MARK:UIButton背景点击效果
    func setBackground(normalColor:UIColor = .white,highLightColor:UIColor = dividerGray){
        self.backgroundColor = normalColor
        self.setBackgroundImage(UIImage.createColorImage(normalColor), for: .normal)
        self.setBackgroundImage(UIImage.createColorImage(highLightColor), for: .highlighted)
    }
}
extension UILabel {
    //MARLK:UILabel设置lineHight
    func setText(text:String,font:UIFont,lineHeight:CGFloat){
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = lineHeight - font.lineHeight
        let attributes = [NSAttributedString.Key.font:font,NSAttributedString.Key.paragraphStyle: paraph]
        self.attributedText = NSAttributedString(string: text, attributes: attributes)
    }
    
    //MARK:UILAbel富文本显示
    func setHTML(text:String,font:UIFont,lineHeight:CGFloat){
        self.attributedText = text.htmlToAttributedString
    }
}


extension String {
    //MARK:富文本格式化
    var htmlToAttributedString: NSMutableAttributedString {
        guard let data = data(using: .utf8) else { return NSMutableAttributedString() }
        do {
            return try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSMutableAttributedString()
        }
    }
}

//MARK:计算UILabel高度，⚠️lineHeight必须大于font.lineHeight
func fetchLabelHeight(_ text:String,font:UIFont,width:CGFloat,lineHeight:CGFloat) -> CGFloat {
        let statusLabelText: NSString = text as NSString
        let size = CGSize(width: width, height: 9999)
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = lineHeight - font.lineHeight
        let attributes = [NSAttributedString.Key.font:font,NSAttributedString.Key.paragraphStyle: paraph]
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return strSize.height
}
