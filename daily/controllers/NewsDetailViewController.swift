//
//  NewsDetailViewController.swift
//  daily
//
//  Created by 郑泰捐 on 2019/11/28.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import WebKit
import RxSwift

class NewsDetailViewController: BaseViewController {
    @IBOutlet weak var favorite: UIButton!
    @IBOutlet weak var like: UIButton!
    @IBOutlet weak var share: UIButton!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var container: UIView!
    private let webView = WKWebView(frame: .zero)
    private lazy var loadingDialog = LoadingView(self.view)
    private var dataId:String = ""
    private lazy var newsDetailViewModel = NewsDetailViewModel(self.dataId)
    private lazy var favoriteViewModel = FavoriteViewModel()
    private lazy var likeViewModel = LikeViewModel()
    private var data = News.none
    
    //MARK:设置dataId
    func setDataId(_ dataId:String){
        self.dataId = dataId
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
            self.like.setImage(UIImage(named: "hk_like"), for: .normal)
        }).disposed(by: disposeBag)
    }
    
    //MARK:返回
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:分享
    @IBAction func shareAction(_ sender: Any) {
        if self.data === News.none {
            //MARK:详情数据正在请求，或者请求失败
            return
        }
        ShareViewController.show(title: self.data.title, desc: self.data.description, imageUrl: self.data.imageFulUrl(), webUrl: self.data.webUrl())
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        LogUtils.info(self.container == nil)
        self.divider.backgroundColor = dividerGray
        self.container.addSubview(self.webView)
        //MARK:加载动画显示
        self.loadingDialog.showLoading()
        //MARK:详情数据监听
        newsDetailViewModel.data.subscribe(onNext: { (result) in
            switch result {
            case .none:break
            case .error(_):break
            case .refreshError(_):break
            case .loadMoreError(_):break
            case .success(let data):
                self.data = data
                self.webView.loadHTMLString(data.text, baseURL: URL(string: ImageDNS)!)
                break
            case .refreshSuccess(_):break
            case .loadMoreSuccess(_):break
            }
            self.loadingDialog.hideLoading()
        }).disposed(by: disposeBag)
        //MARK:详情数据请求
        newsDetailViewModel.loadDetail()
        //MARK:监听收藏状态变化
        self.favoriteViewModel.isExit.observeOn(MainScheduler.instance).subscribe(onNext: { (flag) in
           if flag {
                self.favorite.setImage(UIImage(named: "hk_favorite"), for: .normal)
            } else {
                self.favorite.setImage(UIImage(named: "hk_favorite_normal"), for: .normal)
            }
        }).disposed(by: disposeBag)
        //MARK:获取收藏状态
        favoriteViewModel.exit(self.dataId)
    }
    
    override func viewDidLayoutSubviews() {
        //MARK:是指webView的位置
        self.webView.frame = self.container.bounds
    }
}
