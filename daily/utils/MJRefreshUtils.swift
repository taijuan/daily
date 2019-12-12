//
//  MJRefreshUtils.swift
//  daily
//
//  Created by 郑泰捐 on 2019/11/22.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import MJRefresh

//MARK:下拉刷新、上拉加载更多扩展
extension UITableView {
   
    //MARK:刷新UI
    func registerHeader(action:@escaping ()->Void){
        self.mj_header = MJRefreshNormalHeader()
        self.mj_header.isAutomaticallyChangeAlpha = true
        self.mj_header.refreshingBlock = {
            action()
        }
        self.mj_header.beginRefreshing()
    }
    
    //MARK:加载更多UI
    func registerFooter(action:@escaping ()->Void){
        self.mj_footer = MJRefreshAutoNormalFooter()
        self.mj_footer.refreshingBlock = {
            action()
        }
    }
}
