//
//  RegexUtils.swift
//  daily
//
//  Created by 郑泰捐 on 2019/12/10.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import Foundation

extension String {
    //MARK:email验证
    func isEmail() -> Bool {
        if self.count == 0 {
            return false
        }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
}
