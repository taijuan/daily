//
//  CacheNews.swift
//  daily
//
//  Created by 郑泰捐 on 2019/11/29.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import Foundation

import RealmSwift

//MARK:栏目首屏数据缓存CacheDB
class CacheNews:Object{
    @objc dynamic var id:String = ""
    @objc dynamic var dataId:String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var bigTitleImage: String = ""
    @objc dynamic var dataType:Int = 1
    @objc dynamic var subjectName:String = ""
    @objc dynamic var subjectCode:String = ""
    @objc dynamic var fullPublishTime:String = ""
    @objc dynamic var xdescription:String = ""
    //MARK:栏目数据缓存tag
    @objc dynamic var tag:String = ""
    //MARK:栏目数据第一页数据缓存，数据库primaryKey必须是dataId和tag组合才能区分
    @objc dynamic var dataIdAndTag = ""
    override static func primaryKey() -> String? {
        return "dataIdAndTag"
    }
}
extension CacheNews {
    func toNews()->News{
        let news = News()
        news.id = self.id
        news.dataId = self.dataId
        news.title = self.title
        news.bigTitleImage = self.bigTitleImage
        news.dataType = self.dataType
        news.subjectName = self.subjectName
        news.subjectCode = self.subjectCode
        news.fullPublishTime = self.fullPublishTime
        news.description = self.xdescription
        return news
    }
}
