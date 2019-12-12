//
//  DataResult.swift
//  daily
//
//  Created by 郑泰捐 on 2019/11/22.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import HandyJSON

class DataResult<T>: HandyJSON {
    required init(){}
    var dateList:Array<T> = []
    var top_focus:Array<T> = []
    var allLists:Array<T> = []
    var totalPage:Int = 0
    var currentPage:Int = 0
}

