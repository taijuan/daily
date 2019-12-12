//
//  ClearCacheUtils.swift
//  daily
//
//  Created by 郑泰捐 on 2019/12/9.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import Foundation

class ClearCacheUtils{
    //MARK:获取缓存大小
    class func getCacheSize() -> String {
        //cache文件夹
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        //文件夹下所有文件
        let files = FileManager.default.subpaths(atPath: cachePath!)!
        //遍历计算大小
        var size = 0
        for file in files {
            //文件名拼接到路径中
            let path = cachePath! + "/\(file)"
            //取出文件属性
            do {
                let floder = try FileManager.default.attributesOfItem(atPath: path)
                for (key, fileSize) in floder {
                    //累加
                    if key == FileAttributeKey.size {
                        size += (fileSize as AnyObject).integerValue
                    }
                }
            } catch {
                print("出错了！")
            }
            
        }
        
        let totalSize = Double(size) / 1024.0 / 1024.0
        return String(format: "%.1fM", totalSize)
    }


    //MARK:删除缓存
    class func clearCache() {
        //cache文件夹
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        //文件夹下所有文件
        let files = FileManager.default.subpaths(atPath: cachePath!)!
        
        //遍历删除
        for file in files {
            //文件名
            let path = cachePath! + "/\(file)"
            //存在就删除
            if FileManager.default.fileExists(atPath: path) {
                do {
                    try FileManager.default.removeItem(atPath: path)
                } catch {
                    print("出错了！")
                }
            }
        }
    }
}
