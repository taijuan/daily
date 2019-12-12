//
//  FavoriteTableViewController.swift
//  daily
//
//  Created by 郑泰捐 on 2019/12/4.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import RxSwift
import JXSegmentedView

class FavoriteTableViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    private var code = ""
    private let favoriteViewModel = FavoriteViewModel()
    private var data = Array<News>()
    
    func setCode(_ code :String){
        self.code = code
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        self.favoriteViewModel.data.observeOn(MainScheduler.instance).subscribe(onNext: { (data) in
            self.data = data
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        self.favoriteViewModel.favorites(self.code)
    }
    
}

extension FavoriteTableViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count * 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if row%2 == 1{
            return tableView.dequeueReusableCell(withIdentifier: "FavoriteDividerTableViewCell", for: indexPath)
        }else{
            let item = self.data[row/2]
            if item.isVideo() {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteVideoTableViewCell", for: indexPath) as!FavoriteVideoTableViewCell
                cell.refresh(item)
                return cell
            } else if item.isOpinion(){
                let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteOpinionTableViewCell", for: indexPath) as!FavoriteOpinionTableViewCell
                cell.refresh(item)
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteNewsTableViewCell", for: indexPath) as!FavoriteNewsTableViewCell
                cell.refresh(item)
                return cell
            }
        }
    }
}

extension FavoriteTableViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.data[indexPath.row/2]
        if item.isVideo() {
            self.navigationController?.pushViewController(videoDetailViewController(item.dataId), animated: true)
        }else{
            self.navigationController?.pushViewController(newsDetailViewController(item.dataId), animated: true)
        }
    }
}

extension FavoriteTableViewController:JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return self.view
    }
}
