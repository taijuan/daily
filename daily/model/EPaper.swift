//
//  EPaper.swift
//  daily
//
//  Created by 郑泰捐 on 2019/12/6.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import HandyJSON

class EpaperData:HandyJSON{
    required init() {}
    var newestPubDate:Array<EPaper> = []
}
class EPaper: HandyJSON {
    required init(){}
    var publicationCode:String = ""
    var publicationName:String = ""
    var pubDate:String = ""
    var publicationConfig:PublicationConfig? = nil
    var imageUrl:String = ""
    var htmlUrl:String = ""
}

extension EPaper {
    func toCacheEPaper() ->CacheEPaper{
        let epaper = CacheEPaper()
        epaper.publicationCode = self.publicationCode
        epaper.publicationName = self.publicationName
        epaper.pubDate = self.pubDate
        epaper.imageUrl = self.imageUrl
        epaper.htmlUrl = self.htmlUrl
        return epaper
    }
}
class PublicationConfig:HandyJSON {
    required init(){}
    var isHide:Int = 0
}


class EPaperImages:HandyJSON{
    required init(){}
    var data:Array<EPaperImage> = []
}

class EPaperImage:HandyJSON{
    required init(){}
    var snapshotBigUrl:String = ""
}

