//
//  NewsDetailViewmodel.swift
//  daily
//
//  Created by 郑泰捐 on 2019/11/28.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import RxSwift
import Alamofire

class NewsDetailViewModel {
    private let dataId:String
    private let dataBv = BehaviorSubject<State<News>>(value: .none)
    //MARK:ViewController数据回调监听
    let data: Observable<State<News>>
    
    private let lastedDataBv = BehaviorSubject<State<Array<News>>>(value: .none)
    let lastedData:Observable<State<Array<News>>>
    
    //MARK:构造函数
    init(_ dataId:String) {
        self.dataId = dataId
        data = dataBv.asObserver()
        lastedData = lastedDataBv.asObserver()
    }
    
    //MARK:详情数据请求
    func loadDetail(){
        let url = "\(DNS)/selecNewsDetail?dataId=\(self.dataId)"
        LogUtils.info(url)
        AF.request(url,method: .get).responseString { (response) in
            switch(response.result){
            case .failure(let error):
                self.dataBv.onNext(.error(error.errorDescription!))
            case .success(let success):
                let result = BaseRes<News>.deserialize(from: success)
                if result?.resCode == 200 {
                    self.dataBv.onNext(.success(result!.resObject!))
                } else {
                    self.dataBv.onNext(.error(result!.resMsg!))
                }
            }
        }
    }
    
    //MARK:视频推荐
    func loadLastedData(_ code:String){
        let url = "\(DNS)/selectNewsList?subjectCode=\(code)&currentPage=1&dataType=3"
        _ = AF.request(url, method: .get).responseString { (response) in
           switch(response.result){
            case .failure(let error):
                self.lastedDataBv.onNext(.error(error.errorDescription ?? ""))
            case .success(let success):
                let a = BaseRes<DataResult<News>>.deserialize(from: success)
                if a != nil && a?.resCode  == 200 && a?.resObject != nil {
                    var arr = a?.resObject?.dateList ?? []
                    arr = arr.filter{a in return a.dataId != self.dataId}
                    self.lastedDataBv.onNext(.success(arr))
                }else{
                    self.lastedDataBv.onNext(.error(a!.resMsg ?? ""))
                }
            }
        }
    }
}
