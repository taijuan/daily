//
//  MeViewController.swift
//  daily
//
//  Created by 郑泰捐 on 2019/11/27.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import JXSegmentedView
import RxSwift

let favoriteViewModel = FavoriteViewModel()

class MeViewController: BaseViewController {
    @IBOutlet weak var meLabel: UILabel!
    @IBOutlet weak var firstDivider: UIView!
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var twitterBtn: UIButton!
    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var favoriteLabelView: UIView!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var tabLayout: UIView!
    @IBOutlet weak var pageView: UIView!
    private lazy var segmentedView:JXSegmentedView = {
        let view = JXSegmentedView()
        let indicator = JXSegmentedIndicatorLineView()
        indicator.lineStyle = .normal
        indicator.indicatorColor = textBlue
        view.indicators = [indicator]
        view.dataSource = dataSource
        view.delegate = self
        return view
    }()
    
    private lazy var segmentedListContainerView : JXSegmentedListContainerView = {
        let view = JXSegmentedListContainerView(dataSource: self)
        self.segmentedView.contentScrollView = view.scrollView
        return view
    }()
    
    private lazy var dataSource : JXSegmentedTitleDataSource = {
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.itemSpacing = 12
        dataSource.isItemSpacingAverageEnabled = true
        dataSource.isTitleColorGradientEnabled = false
        dataSource.titleNormalColor = textBlack
        dataSource.titleSelectedColor = textBlue
        dataSource.titleNormalFont = latoRegular(18)
        dataSource.titleSelectedFont = latoBold(18)
        dataSource.titles = []
        return dataSource
    }()
   
    @IBAction func facebookAction(_ sender: Any) {
        self.navigationController?.pushViewController(webViewController("Facebook", facebookDNS), animated: true)
    }
    @IBAction func twitterAction(_ sender: Any) {
        self.navigationController?.pushViewController(webViewController("Twitter", twitterDNS), animated: true)
    }
    @IBAction func settingsAction(_ sender: Any) {
        self.navigationController?.pushViewController(settingsViewController(), animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.meLabel.font = latoSemibold(20)
        self.meLabel.textColor = textBlack
        
        self.settingsBtn.setBackground()
        
        self.firstDivider.backgroundColor = dividerGray
        
        self.facebookBtn.titleLabel?.font = latoRegular(16)
        self.facebookBtn.titleLabel?.text = "Facebook"
        self.facebookBtn.setTitleColor(textBlack, for: .normal)
        self.facebookBtn.setBackground()
        self.facebookBtn.setViewShadow(borderColor:dividerGray,cornerRadius: 8)
        
        self.twitterBtn.titleLabel?.font = latoRegular(16)
        self.twitterBtn.titleLabel?.text = "Twitter"
        self.twitterBtn.setTitleColor(textBlack, for: .normal)
        self.twitterBtn.setBackground()
        self.twitterBtn.setViewShadow(borderColor:dividerGray,cornerRadius: 8)
        
        self.favoriteLabelView.backgroundColor = dividerGray
        self.favoriteLabel.textColor = textBlack
        self.favoriteLabel.font = latoRegular(16)
        
        self.tabLayout.addSubview(self.segmentedView)
        
        self.pageView.addSubview(self.segmentedListContainerView)
        
        favoriteViewModel.columns.observeOn(MainScheduler.instance).subscribe(onNext: { (columns) in
            //MARK:设置tab居中
            let width = 70*columns.count
            let x = (240 - width)/2
            self.segmentedView.frame = CGRect(x: x, y: 0, width: width, height: 44)
            self.dataSource.titles = columns
            self.segmentedView.reloadDataWithoutListContainer()
            self.segmentedListContainerView.reloadData()
            self.segmentedView.reloadItem(at: 0)
        }).disposed(by: disposeBag)
        self.fetchColumns()
        //MARK:注册广播
        NotificationCenter.default.addObserver(self, selector: #selector(fetchColumns), name: Notification.Name(rawValue: "refresh_column"), object: nil)
    }
    
    deinit {
        //MARK:注销广播
        NotificationCenter.default.removeObserver(self)
    }
    //MARK:刷新Columns
    @objc func fetchColumns(){
        LogUtils.info("fetchColumns")
        favoriteViewModel.fetchColumns()
    }
    
    //MARK:设置布局frame
    override func viewDidLayoutSubviews() {
        self.segmentedListContainerView.frame = self.pageView.bounds
    }
}

extension MeViewController:JXSegmentedListContainerViewDataSource{
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        return favoriteTableViewController(self.dataSource.titles[index])
    }
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return self.dataSource.titles.count
    }
}

extension MeViewController: JXSegmentedViewDelegate {
    
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
        //传递didClickSelectedItemAt事件给listContainerView，必须调用！！！
        self.segmentedListContainerView.didClickSelectedItem(at: index)
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, scrollingFrom leftIndex: Int, to rightIndex: Int, percent: CGFloat) {
        //传递scrollingFrom事件给listContainerView，必须调用！！！
        self.segmentedListContainerView.scrolling(from: leftIndex, to: rightIndex, percent: percent, selectedIndex:segmentedView.selectedIndex)
    }
}
