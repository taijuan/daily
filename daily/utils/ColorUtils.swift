//
//  ColorUtils.swift
//  daily
//
//  Created by 郑泰捐 on 2019/11/12.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

//MARK:UIColor扩展
extension UIColor {
    // MARK: 把“#FFFFFFFF”格式的颜色转换成UIColor
    convenience init(hex: String) {
        let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let a = Int(color >> 24) & mask
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let alpha = CGFloat(a) / 255.0
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

//MARK:字体颜色蓝色
let textBlue = UIColor(hex: "#FF2E70C8")
//MARK:字体颜色黑色
let textBlack = UIColor(hex: "#FF262B2E")
//MARK:字体颜色灰色
let textGray = UIColor(hex: "#FF727273")

let textWhite = UIColor(hex: "#FFFFFFFF")

//MARK:背景颜色蓝色
let backgroundBlue = UIColor(hex: "#FF2E70C8")
//MARK:背景颜色黑色
let backgroundBlack = UIColor(hex: "#FF262B2E")


let dividerGray = UIColor(hex: "#FEE4E4E4")


let halfTransparent = UIColor(hex: "#80FFFFFF")
