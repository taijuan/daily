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
        let header = MJRefreshNormalHeader()
        header.setTitle("Pull down to refresh", for: .idle)
        header.setTitle("Pull down to refresh", for: .pulling)
        header.setTitle("Release to refresh", for: .willRefresh)
        header.setTitle("Loading...", for: .refreshing)
        header.lastUpdatedTimeLabel.isHidden = true
        self.mj_header = header
        self.mj_header.isAutomaticallyChangeAlpha = true
        self.mj_header.refreshingBlock = {
            action()
        }
        self.mj_header.beginRefreshing()
    }
    
    //MARK:加载更多UI
    func registerFooter(action:@escaping ()->Void){
        let footer = MJRefreshAutoNormalFooter()
        footer.setTitle("Tap or pull up to load more", for: .idle)
        footer.setTitle("Loading...", for: .refreshing)
        footer.setTitle("No more data", for: .noMoreData)
        self.mj_footer = footer
        self.mj_footer.refreshingBlock = {
            action()
        }
    }
}
