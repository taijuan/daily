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
    
    //MARK:时间格式化
    func weekMonthDayYearHourMinute() ->String{
        LogUtils.info(self)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: self)
        if date == nil {
            return ""
        }
        let components =  Calendar.init(identifier: .gregorian).dateComponents(Set<Calendar.Component>([.weekday,.year, .month, .day,.hour,.minute,]), from: date!)
        let weekDay = components.weekday ?? 1
        let year = components.year ?? 2019
        let month = components.month ?? 1
        let day = components.day ?? 1
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        return "\(WEEKS[weekDay-1]) \(MONTHS[month-1]) \(day), \(year),\(String(format: "%02d", arguments: [hour])):\(String(format: "%02d", arguments: [minute]))"
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
