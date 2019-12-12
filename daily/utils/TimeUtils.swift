//
//  TimeUtils.swift
//  daily
//
//  Created by 郑泰捐 on 2019/12/4.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit


private let MONTHS = ["January","February","March","April","May","June","July","August","September","October","November","December"]
private let SHORT_MONTHS = [ "Jan.","Feb.","Mar.","Apr.","May.","Jun.","Jul.","Aug.","Sep.","Oct.","Nov.","Dec."]
private let WEEKS = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]

extension String {
    //MARK:时间格式化
    func yearMonthDay() ->String{
        LogUtils.info(self)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: self)
        if date == nil {
            return ""
        }
        let components =  Calendar.init(identifier: .gregorian).dateComponents(Set<Calendar.Component>([.year, .month, .day]), from: date!)
        let year = components.year ?? 2019
        let month = components.month ?? 1
        let day = components.day ?? 1
        return "\(SHORT_MONTHS[month-1]) \(day), \(year)"
    }
}


func monthDayYearFromNow()->String{
    let components =  Calendar.init(identifier: .gregorian).dateComponents(Set<Calendar.Component>([.year, .month, .day]), from: Date())
           let year = components.year ?? 2019
           let month = components.month ?? 1
           let day = components.day ?? 1
           return "\(MONTHS[month-1]) \(day)\n\(year)"
}

func year() ->String{
    let components =  Calendar.init(identifier: .gregorian).dateComponents(Set<Calendar.Component>([.year]), from: Date())
    let year = components.year ?? 2019
    return "\(year)"
}
