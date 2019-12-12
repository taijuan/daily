//
//  FavoriteViewModel.swift
//  daily
//
//  Created by 郑泰捐 on 2019/11/29.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift

class FavoriteViewModel{
    private let columnsBv = BehaviorSubject<Array<String>>(value: [])
    private let isExitBV = BehaviorSubject<Bool>(value: false)
    private let dataBV = BehaviorSubject<Array<News>>(value: [])
    let isExit: Observable<Bool>
    let columns:Observable<Array<String>>
    let data:Observable<Array<News>>
    init(){
        isExit = self.isExitBV.asObserver()
        columns = self.columnsBv.asObserver()
        data = self.dataBV.asObserver().filter({ a in return !a.isEmpty })
    }
    //MARK:是否收藏
    func exit(_ dataId:String){
        DispatchQueue.global().async {
            let realm = try!Realm()
            let predicate = NSPredicate(format: "dataId == %@",dataId)
            let favorites = realm.objects(Favorite.self).filter(predicate)
            self.isExitBV.onNext(!favorites.isEmpty)
        }
    }
    
    
    //MARK:收藏
    func save(_ data:News){
        DispatchQueue.global().async {
            let realm = try!Realm()
            realm.beginWrite()
            realm.add(data.toFavorite(),update: .modified)
            try!realm.commitWrite()
            self.exit(data.dataId)
        }
    }
    
    
    //MARK:删除一条收藏
    func delete(_ data:News){
        DispatchQueue.global().async {
            let realm = try!Realm()
            realm.beginWrite()
            let predicate = NSPredicate(format: "dataId == %@",data.dataId)
            let favorites = realm.objects(Favorite.self).filter(predicate)
            if !favorites.isEmpty{
                realm.delete(favorites)
            }
            try!realm.commitWrite()
            self.exit(data.dataId)
        }
    }
    
    //MARK:保存或者删除
    func saveOrDelete(_ data:News){
        DispatchQueue.global().async {
            let realm = try!Realm()
            let predicate = NSPredicate(format: "dataId == %@",data.dataId)
            let favorites = realm.objects(Favorite.self).filter(predicate)
            realm.beginWrite()
            if(favorites.isEmpty){
                realm.add(data.toFavorite(),update: .modified)
            }else{
                realm.delete(favorites)
            }
            try!realm.commitWrite()
            self.exit(data.dataId)
            NotificationCenter.default.post(name:  Notification.Name(rawValue: "refresh_column"), object: nil)
        }
    }
    //MARK:查看收藏列表
    func favorites(_ code:String){
        DispatchQueue.global().async {
            let realm = try!Realm()
            var arr:Array<News> = []
            if code == "News" {
                let favorites = realm.objects(Favorite.self).filter("subjectCode != %@ and dataType != %@", "opinion",3)
                favorites.forEach{ a in
                    arr.append(a.toNews())
                }
            }else if code == "Opinion"{
                let favorites = realm.objects(Favorite.self).filter("subjectCode == %@ and dataType != %@", "opinion",3)
                favorites.forEach{ a in
                    arr.append(a.toNews())
                }
            }else{
                let favorites = realm.objects(Favorite.self).filter("dataType == %@",  3)
                favorites.forEach{ a in
                    arr.append(a.toNews())
                }
            }
            arr.reverse()
            self.dataBV.onNext(arr)
        }
    }
    
    func fetchColumns(){
        DispatchQueue.global().async {
            var d = Array<String>()
            let realm = try!Realm()
            
            let newsArr = realm.objects(Favorite.self).filter("subjectCode != %@ and dataType != %@", "opinion",3)
            if !newsArr.isEmpty {
                d.append("News")
            }
            
            let opinions = realm.objects(Favorite.self).filter("subjectCode == %@ and dataType != %@", "opinion",3)
            if !opinions.isEmpty {
                d.append("Opinion")
            }
            
            let videos = realm.objects(Favorite.self).filter("dataType == %@", 3)
            if !videos.isEmpty {
                d.append("Video")
            }
            self.columnsBv.onNext(d)
        }
    }
}




