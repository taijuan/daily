//
//  LikeViewModel.swift
//  daily
//
//  Created by 郑泰捐 on 2019/11/29.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import RxSwift
import Alamofire

class LikeViewModel{
    
    //MARK:点赞提交
    func like(_ dataId:String)->Observable<String>{
        return Observable<String>.create{observer ->Disposable in
            _ = AF.request("\(DNS)/like?newsId=\(dataId)", method: .get).responseString(completionHandler:{(response) in
                observer.onNext("")
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }
}
