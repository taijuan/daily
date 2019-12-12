//
//  News.swift
//  daily
//
//  Created by 郑泰捐 on 2019/11/22.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import HandyJSON
import RealmSwift

class News:HandyJSON{
    required init(){}
    var id:String = ""
    var dataId:String = ""
    var title: String = ""
    var bigTitleImage: String = ""
    var headImage:String = ""
    var dataType:Int = 1
    var subjectName:String = ""
    var subjectCode:String = ""
    var fullPublishTime:String = ""
    var jsonUrl:String = ""
    var htmlUrl:String = ""
    var description:String = ""
    var text:String = ""
    var tag:String = ""
    var txyUrl:String = ""
    var ytbUrl:String = ""
    func isOpinion() -> Bool {
        return subjectCode == "opinion"
    }
    
    func isVideo() -> Bool {
        return dataType == 3
    }
    
    func imageUrl()->String{
        return bigTitleImage.isEmpty ? headImage:bigTitleImage
    }

    func imageFulUrl() -> String{
        return "\(ImageDNS)\(self.imageUrl())"
    }
    
    func time()->String{
        return self.fullPublishTime.yearMonthDay()
    }
    func webUrl()->String{
        return "\(ImageDNS)\(self.htmlUrl)"
    }
    
    static let none = News()
}

extension News {
    func toFavorite()->Favorite{
        let favirite = Favorite()
        favirite.id = self.id
        favirite.dataId = self.dataId
        favirite.title = self.title
        favirite.bigTitleImage = self.imageUrl()
        favirite.dataType = self.dataType
        favirite.subjectName = self.subjectName
        favirite.subjectCode = self.subjectCode
        favirite.fullPublishTime = self.fullPublishTime
        favirite.xdescription = self.description
        return favirite
    }
}


extension News {
    func toCacheNews()->CacheNews{
        let cache = CacheNews()
        cache.id = self.id
        cache.dataId = self.dataId
        cache.title = self.title
        cache.bigTitleImage = self.imageUrl()
        cache.dataType = self.dataType
        cache.subjectName = self.subjectName
        cache.subjectCode = self.subjectCode
        cache.fullPublishTime = self.fullPublishTime
        cache.xdescription = self.description
        cache.dataIdAndTag = self.dataId + tag
        return cache
    }
}
