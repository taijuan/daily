//
//  EPaperViewModel.swift
//  daily
//
//  Created by 郑泰捐 on 2019/12/6.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import RxSwift
import Alamofire
import RealmSwift

class EPaperViewModel{
    private let epaperBv = BehaviorSubject<State<Array<EPaper>>>(value: .none)
    let data:Observable<State<Array<EPaper>>>
    init(){
        data = epaperBv.asObserver()
    }
    
    //MARK:请求EPaper地址
    func loadData(){
        _ = AF.request("\(EPaperDNS)/pubs/config.json", method: .get).responseString(queue:.global()) { (response) in
            switch response.result {
            case .failure(let error):
                self.getCacheAndPostData(error.errorDescription ?? "")
                break
            case .success(let success):
                let a = EpaperData.deserialize(from: success)
                let arr = (a?.newestPubDate ?? []).filter({a in return a.publicationConfig?.isHide == 0})
                self.fetchImages(arr)
            }
        }
    }
    
    //MARK:解析EPaper图片地址
    fileprivate func fetchImages(_ data:Array<EPaper>){
        let a = Date().timeIntervalSince1970
        LogUtils.success("start")
        let queue = DispatchQueue.global()
        let group = DispatchGroup()
        data.forEach { (item) in
            let url = "\(EPaperDNS)/pubs/\(item.publicationCode)/\(self.strFormat(date: item.pubDate))/issue.json"
            item.htmlUrl = "\(EPaperDNS)/mobile/index.html?pubCode=\(item.publicationCode)&pubDate=\(item.pubDate)"
            group.enter()
            queue.async(group: group){
                let b = Date().timeIntervalSince1970
                AF.request(url, method: .get).responseString{ (response) in
                    switch(response.result){
                    case .success(let success):
                        let a = EPaperImages.deserialize(from: success)
                        item.imageUrl = "\(EPaperDNS)/pubs\(a?.data[0].snapshotBigUrl ?? "")"
                    case .failure(_):
                        item.imageUrl = ""
                    }
                    group.leave()
                    LogUtils.success(Date().timeIntervalSince1970 - b)
                    LogUtils.success(item.imageUrl)
                }
            }
        }
         _ = group.wait(wallTimeout: DispatchWallTime.distantFuture)
        LogUtils.success("end \(Date().timeIntervalSince1970 - a)")
        self.saveCacheAndPostData(data)
        
    }
    
    //MARK: 时间格式化
    fileprivate func strFormat(date: String)-> String{
        var newDate: String = ""
        if (date.contains("-")) {
            newDate = date.replacingOccurrences(of: "-", with: "/")
        }
        return newDate
    }
    
    //MARK:缓存EPaper并发送数据
    fileprivate func saveCacheAndPostData(_ data:Array<EPaper>){
        let realm = try!Realm()
        realm.beginWrite()
        realm.deleteAll()
        data.forEach { (epaper) in
            realm.add(epaper.toCacheEPaper(), update: .modified)
        }
        try!realm.commitWrite()
        self.epaperBv.onNext(.success(data))
    }
    
    //MARK:获取缓存并发送数据
    fileprivate func getCacheAndPostData(_ error:String){
        let realm = try!Realm()
        let caches = realm.objects(CacheEPaper.self)
        var data = Array<EPaper>()
        caches.forEach { (cache) in
            data.append(cache.toEPaper())
        }
        if data.isEmpty{
            self.epaperBv.onNext(.error(error))
        }else{
            self.epaperBv.onNext(.success(data))
        }
    }
}
