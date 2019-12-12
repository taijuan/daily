//
//  FontUtils.swift
//  daily
//
//  Created by 郑泰捐 on 2019/11/22.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

//MARK:测试查询自定义Fonts的FontName
func test(){
    UIFont.fontNames(forFamilyName: "Lato").forEach { (fontName) in
        LogUtils.info(fontName)
    }
    UIFont.familyNames.forEach { (fontName) in
        LogUtils.info(fontName)
    }
}

//MARK:latoRegular
func latoRegular(_ size :CGFloat) -> UIFont {
    return UIFont(name: "Lato-Regular", size: size)!
}

//MARK:latoSemibold
func latoSemibold(_ size :CGFloat) -> UIFont {
    return UIFont(name: "Lato-Semibold", size: size)!
}

//MARK:latoBold
func latoBold(_ size :CGFloat) -> UIFont {
    return UIFont(name: "Lato-Bold", size: size)!
}
