//
//  VideoDetailViewController.swift
//  daily
//
//  Created by 郑泰捐 on 2019/12/2.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import BMPlayer
import RxSwift

class VideoDetailViewController: BaseViewController {
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    private lazy var player = BMPlayer()
    private var dataId:String = ""
    
    private lazy var detailViewModel = NewsDetailViewModel(self.dataId)
    private lazy var favoriteViewModel = FavoriteViewModel()
    private lazy var likeViewModel = LikeViewModel()
    private var data = News.none
    
    private lazy var loadingDialog = LoadingView(self.view)
    private var lastedData = Array<News>()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func setDataId(_ dataId:String){
        self.dataId = dataId
    }
    //MARK:返回
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func shareAction(_ sender: Any) {
        if self.data === News.none {
            //MARK:详情数据正在请求，或者请求失败
            return
        }
        ShareViewController.show(title: self.data.title, desc: self.data.description, imageUrl: self.data.imageFulUrl(), webUrl: self.data.webUrl())
    }
    
    //MARK:收藏
    @IBAction func favoriteAction(_ sender: Any) {
        if self.data === News.none {
            //MARK:详情数据正在请求，或者请求失败
            return
        }
        favoriteViewModel.saveOrDelete(self.data)
    }
    //MARK:点赞
    @IBAction func likeAction(_ sender: Any) {
        likeViewModel.like(self.dataId).observeOn(MainScheduler.instance).subscribe(onNext: { (isLike) in
            self.likeBtn.setImage(UIImage(named: "hk_like"), for: .normal)
        }).disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initPlayer()
        self.initUITableView()
        
        self.loadingDialog.showLoading()
        self.detailViewModel.data.observeOn(MainScheduler.instance).subscribe(onNext: { (result) in
            switch result {
            case .none:break
            case .error(_):break
            case .refreshError(_):break
            case .loadMoreError(_):break
            case .success(let success):
                self.data = success
                self.lastedLoadData()
                let url = URL(string: self.data.txyUrl)
                if(url != nil){
                    let asset = BMPlayerResource(url: url!,name: self.data.title, cover:URL(string: self.data.imageFulUrl()))
                    self.player.setVideo(resource: asset)
                }
                self.tableView.reloadData()
                break
            case .refreshSuccess(_):break
            case .loadMoreSuccess(_):break
            }
            self.loadingDialog.hideLoading()
        }).disposed(by: disposeBag)
        self.detailViewModel.loadDetail()
        
        //MARK:监听收藏状态变化
        self.favoriteViewModel.isExit.observeOn(MainScheduler.instance).subscribe(onNext: { (flag) in
           if flag {
                self.favoriteBtn.setImage(UIImage(named: "hk_favorite"), for: .normal)
            } else {
                self.favoriteBtn.setImage(UIImage(named: "hk_favorite_normal"), for: .normal)
            }
        }).disposed(by: disposeBag)
        //MARK:获取收藏状态
        favoriteViewModel.exit(self.dataId)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.appDelegate.blockRotation = true
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.appDelegate.blockRotation = false
    }
}

//MARK:播放器设置
extension VideoDetailViewController:BMPlayerDelegate{
    
    func initPlayer(){
        self.playerView.addSubview(self.player)
        self.player.frame = self.playerView.bounds
        self.player.delegate = self
        self.player.backBlock = { isFull in
            if isFull == false {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
           self.player.play()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.player.pause(allowAutoPlay: false)
    }
    
    
    func bmPlayer(player: BMPlayer, playerStateDidChange state: BMPlayerState) {
        
    }
    
    func bmPlayer(player: BMPlayer, loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval) {
        
    }
    
    func bmPlayer(player: BMPlayer, playTimeDidChange currentTime: TimeInterval, totalTime: TimeInterval) {
        
    }
    
    func bmPlayer(player: BMPlayer, playerIsPlaying playing: Bool) {
        
    }
    
    func bmPlayer(player: BMPlayer, playerOrientChanged isFullscreen: Bool) {
        if isFullscreen == true {
            self.player.removeFromSuperview()
            self.view.addSubview(self.player)
        }else{
            self.player.removeFromSuperview()
            LogUtils.info(self.playerView.bounds)
            self.playerView.addSubview(self.player)
        }
    }
    override func viewDidLayoutSubviews() {
        if self.player.superview != nil {
            self.player.frame = self.player.superview!.bounds
        }
    }
}


//MARK:UITableView 逻辑处理
extension VideoDetailViewController:UITableViewDataSource,UITableViewDelegate {
    //MARK:UITableView初始化
    func initUITableView(){
        self.tableView.separatorStyle = .none
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.detailViewModel.lastedData.observeOn(MainScheduler.instance).subscribe(onNext: { (result) in
            switch result {
            case .none:break
            case .error(_):break
            case .refreshError(_):break
            case .loadMoreError(_):break
            case .success(let success):
                self.lastedData = success
                self.tableView.reloadData()
                break
            case .refreshSuccess(_):break
            case .loadMoreSuccess(_):break
            }
        }).disposed(by: disposeBag)
    }
    
    //MARK:推荐数据请求,注意：必须详情请求成功后，才能调用
    func lastedLoadData(){
        self.detailViewModel.loadLastedData(self.data.subjectCode)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data === News.none ? 0 : 2 + self.lastedData.count*2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LastedHeaderTableViewCell", for: indexPath) as! LastedHeaderTableViewCell
            cell.refresh(self.data)
            return cell
        } else if row == 1 {
            return tableView.dequeueReusableCell(withIdentifier: "LastedTitleTableViewCell", for: indexPath)
        }else if row%2 == 1 {
            return tableView.dequeueReusableCell(withIdentifier: "LastedDividerTableViewCell", for: indexPath)
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LastedTableViewCell", for: indexPath)as!LastedTableViewCell
            cell.refresh(self.lastedData[(row - 2)/2])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        if row>=2{
            let item = self.lastedData[(row - 2)/2]
            self.navigationController?.pushViewController(videoDetailViewController(item.dataId), animated: true)
        }
    }
}
