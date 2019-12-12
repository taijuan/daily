//
//  Favorite.swift
//  daily
//
//  Created by 郑泰捐 on 2019/11/29.
//  Copyright © 2019 郑泰捐. All rights reserved.


import RealmSwift

//MARK:收藏DB表结构
class Favorite:Object{
    @objc dynamic var id:String = ""
    @objc dynamic var dataId:String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var bigTitleImage: String = ""
    @objc dynamic var dataType:Int = 1
    @objc dynamic var subjectName:String = ""
    @objc dynamic var subjectCode:String = ""
    @objc dynamic var fullPublishTime:String = ""
    @objc dynamic var xdescription:String = ""
    
    override static func primaryKey() -> String? {
        return "dataId"
    }
}
extension Favorite {
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
