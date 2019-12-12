//
//  AppUtils.swift
//  daily
//
//  Created by 郑泰捐 on 2019/12/10.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import Foundation

//MARK:版本号
func getVersionName()->String{
    return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
}

//MARK:版本Code
func getVersionCode()->String{
    return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
}
