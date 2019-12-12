//
//  NewsTableViewController.swift
//  daily
//
//  Created by 郑泰捐 on 2019/11/27.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import RxSwift
import JXSegmentedView

class NewsTableViewController: BaseViewController {
    @IBOutlet var tableView: UITableView!
    private var code:String = ""
    private var data:Array<News> = []
    private var focusData:Array<News> = []
    
    private lazy var viewModel = NewsViewModel(self.code)
    func setCode(_ code : String){
        self.code = code
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.data.observeOn(MainScheduler.instance).subscribe(onNext: { (result) in
            switch result {
            case .none: break
            case .error(_): break
            case .refreshError(_):
                self.tableView.mj_header.endRefreshing()
            case .loadMoreError(_):
                self.tableView?.mj_footer.endRefreshing()
            case .success(_):break
            case .refreshSuccess(let data):
                if self.code == "home" {
                    self.focusData = data.top_focus
                    self.data = data.allLists
                }else{
                    self.data = data.dateList
                }
                self.tableView.mj_header.endRefreshing()
                self.tableView.reloadData()
                self.initLoadMoreFooter()
            case .loadMoreSuccess(let data):
                self.data += data.dateList
                self.tableView.mj_footer.endRefreshing()
                self.tableView.reloadData()
            }
        }).disposed(by: disposeBag)
        self.tableView.separatorStyle = .none
        self.tableView.registerHeader {
            self.viewModel.refreshData()
        }
    }
    
    func initLoadMoreFooter(){
        if self.tableView.mj_footer == nil {
            self.tableView.registerFooter {
                self.viewModel.loadMoreData()
            }
            if self.code == "home" {
                self.tableView.mj_footer.endRefreshingWithNoMoreData()
            }
        }
    }
}


//MARK: dataSource
extension NewsTableViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0  {
            return self.focusData.isEmpty ? 0:2
           }
           return self.data.count * 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let section = indexPath.section
        if section == 0 && row == 0 {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "FocusHeaderTableViewCell", for: indexPath) as! FocusHeaderTableViewCell
            cell.refresh(focusData)
            return cell
        } else if section == 0 && row == 1 {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "FocusDividerTableViewCell", for: indexPath) as! FocusDividerTableViewCell
            return cell
        } else if section == 1 && row % 2 == 1 {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "DividerTableViewCell", for: indexPath) as! DividerTableViewCell
            return cell
        } else {
            let item = self.data[indexPath.row / 2]
            if item.isOpinion() {
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "OpinionTableViewCell", for: indexPath) as! OpinionTableViewCell
                cell.refresh(item)
                return cell
            } else if item.isVideo() {
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as! VideoTableViewCell
                cell.refresh(item)
                return cell
            } else {
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
                cell.refresh(item)
                return cell
            }
        }
    }
}


extension NewsTableViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = indexPath.row
        let section = indexPath.section
        if section == 0 && row == 0 {
            return 200
        } else if section == 0 && row == 1{
            return 8
        } else if section == 1 && row % 2 == 1 {
            return 1
        }else {
            let item = self.data[indexPath.row / 2]
            if item.isOpinion() {
                return 142
            } else if item.isVideo() {
                return 300
            }  else {
                return 104
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let item = self.data[indexPath.row/2]
            if item.isVideo() {
                self.navigationController?.pushViewController(videoDetailViewController(item.dataId), animated: true)
            }else{
                self.navigationController?.pushViewController(newsDetailViewController(item.dataId), animated: true)
            }
        }
    }
}

extension NewsTableViewController : JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return self.view
    }
}
