//
//  CacheEPaper.swift
//  daily
//
//  Created by 郑泰捐 on 2019/12/9.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import RealmSwift

class CacheEPaper:Object{
    @objc dynamic var publicationCode:String = ""
    @objc dynamic var publicationName:String = ""
    @objc dynamic var pubDate:String = ""
    @objc dynamic var imageUrl:String = ""
    @objc dynamic var htmlUrl:String = ""
    override class func primaryKey() -> String? {
        return "publicationCode"
    }
}

extension CacheEPaper {
    func toEPaper() ->EPaper{
        let epaper = EPaper()
        epaper.publicationCode = self.publicationCode
        epaper.publicationName = self.publicationName
        epaper.pubDate = self.pubDate
        epaper.imageUrl = self.imageUrl
        epaper.htmlUrl = self.htmlUrl
        return epaper
    }
}
