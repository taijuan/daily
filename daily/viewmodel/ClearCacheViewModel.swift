//
//  ClearCacheViewModel.swift
//  daily
//
//  Created by 郑泰捐 on 2019/12/9.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import RxSwift

class ClearCacheViewModel{
    private let cacheSizeBv = BehaviorSubject<String>(value: "0.0M")
    let cacheSize: Observable<String>
    
    //MARK:构造函数
    init() {
        cacheSize = cacheSizeBv.asObserver()
    }
    
    //MARK:获取缓存大小
    func fetchCacheSize(){
        DispatchQueue.global().async {
            let total = ClearCacheUtils.getCacheSize()
            self.cacheSizeBv.onNext(total)
        }
    }
    
    func clearCache(){
        DispatchQueue.global().async {
            ClearCacheUtils.clearCache()
            self.fetchCacheSize()
        }
    }
}
