//
//  NewsViewModel.swift
//  daily
//
//  Created by 郑泰捐 on 2019/11/22.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import RxSwift
import Alamofire
import RealmSwift

class NewsViewModel {
    private var code = "home"
    private var curPage = 0
    private let dataBv = BehaviorSubject<State<DataResult<News>>>(value: .none)
    let data: Observable<State<DataResult<News>>>
    
    //MARK:构造函数
    init(_ code: String) {
        self.code = code
        data = dataBv.asObserver()
    }
    
    //MARK:刷新数据
    func refreshData() {
        LogUtils.info(getUrl())
        AF.request(getUrl(),method: .get).responseString { (response) in
            switch(response.result){
            case .failure(let failure):
                self.getCacheNewsDataResultAndPostData((failure.errorDescription!))
            case .success(let success):
                let a = BaseRes<DataResult<News>>.deserialize(from: success)
                if (a != nil && a?.resCode == 200) {
                    let dataResult:DataResult<News> = a?.resObject ?? DataResult<News>()
                    self.saveCacheNewsAndPostData(dataResult)
                }else{
                    self.getCacheNewsDataResultAndPostData(a?.resMsg ?? "")
                }
                
            }
        }
    }
    
    //MARK:缓存数据至数据库并发送结果
    func saveCacheNewsAndPostData(_ data:DataResult<News>){
        DispatchQueue.global().async {
            let realm = try!Realm()
            realm.beginWrite()
            if self.code == "home" {
                let focusP = NSPredicate(format: "dataIdAndTag contains %@", "focus")
                let top_focus = realm.objects(CacheNews.self).filter(focusP)
                if !top_focus.isEmpty {
                    realm.delete(top_focus)
                }
                data.top_focus.forEach { (news) in
                    news.tag = "focus"
                    realm.add(news.toCacheNews(), update: .modified)
                }
                let allP = NSPredicate(format: "dataIdAndTag contains %@", "home")
                let allLists = realm.objects(CacheNews.self).filter(allP)
                if !allLists.isEmpty {
                    realm.delete(allLists)
                }
                data.allLists.forEach { (news) in
                    news.tag = "home"
                    realm.add(news.toCacheNews(), update: .modified)
                }
            } else {
                let dateP = NSPredicate(format: "dataIdAndTag contains %@", self.code)
                let dateList = realm.objects(CacheNews.self).filter(dateP)
                if !dateList.isEmpty {
                    realm.delete(dateList)
                }
                data.dateList.forEach { (news) in
                    news.tag = self.code
                    realm.add(news.toCacheNews(), update: .modified)
                }
            }
            try!realm.commitWrite()
            self.dataBv.onNext(.refreshSuccess(data))
            self.curPage =  1
        }
    }
    
    //MARK: 获取缓存并发送结果
    func getCacheNewsDataResultAndPostData(_ error:String){
        DispatchQueue.global().async {
            let dataResult = DataResult<News>()
            let realm = try!Realm()
            if self.code == "home" {
                let focusP = NSPredicate(format: "dataIdAndTag contains %@", "focus")
                dataResult.top_focus = realm.objects(CacheNews.self).filter(focusP).map({ (cache) -> News in
                    cache.toNews()
                })
                let allP = NSPredicate(format: "dataIdAndTag contains %@", "home")
                dataResult.allLists = realm.objects(CacheNews.self).filter(allP).map({ (cache) -> News in
                    cache.toNews()
                })
                if dataResult.allLists.isEmpty {
                    self.dataBv.onNext(.refreshError(error))
                } else {
                    self.dataBv.onNext(.refreshSuccess(dataResult))
                }
            } else {
                let dateP = NSPredicate(format: "dataIdAndTag contains %@", self.code)
                dataResult.dateList = realm.objects(CacheNews.self).filter(dateP).map({ (cache) -> News in
                    cache.toNews()
                })
                if dataResult.dateList.isEmpty {
                    self.dataBv.onNext(.refreshError(error))
                } else {
                    self.dataBv.onNext(.refreshSuccess(dataResult))
                }
            }
        }
    }
    
    //MARK:加载更多
    func loadMoreData() {
        LogUtils.success("\(getUrl(curPage: self.curPage + 1))")
        AF.request(getUrl(curPage: self.curPage + 1), method: .get).responseString(completionHandler: {response in
            switch(response.result){
            case .failure(let failure):
                self.dataBv.onNext(.loadMoreError(failure.errorDescription!))
            case .success(let success):
                let a = BaseRes<DataResult<News>>.deserialize(from: success)
                if (a?.resCode == 200) {
                    self.dataBv.onNext(.loadMoreSuccess(a!.resObject!))
                    self.curPage =  self.curPage + 1
                }else{
                    self.dataBv.onNext(.loadMoreError(a!.resMsg!))
                }
            }
        })
    }

    //MARK:URL拼接
    func getUrl(curPage: Int = 1) -> String {
        if self.code == "home" {
            return "\(DNS)/homeDataNewsList"
        } else if self.code == "video" {
            return "\(DNS)/selectNewsList?currentPage=\(curPage)&dataType=3"
        } else {
            return "\(DNS)/selectNewsList?subjectCode=\(self.code)&currentPage=\(curPage)&dataType=1"
        }
    }
}

