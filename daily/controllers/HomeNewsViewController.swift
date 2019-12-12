//
//  HomeNewsViewController.swift
//  daily
//
//  Created by 郑泰捐 on 2019/11/21.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import JXSegmentedView
import JXBottomSheetView

class HomeNewsViewController: UIViewController {
    
    @IBOutlet weak var tabLayout: UIView!
    
    @IBOutlet weak var tabController: UIView!
    private let tabs:Array<String>  = ["Home","Video" , "Hong Kong", "Nation" ,"Asia","World" , "Opinion","Business","Data" ,"Sports",
                                       "Life & Art" ,"Leaders","Offbeat HK","IN-Depth China","Eye On Asia" ,"Quirky","Photo"]
    private let codes  = ["home","video","hong_kong","nation","asia","world","opinion","business","data","sports","life_art","leaders","offbeat_hk",
                          "in_depth_china","eye_on_asia","quirky","photo"]
    
    private lazy var segmentedView:JXSegmentedView = {
        let view = JXSegmentedView()
        let indicator = JXSegmentedIndicatorBaseView()
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
    
    private lazy var dataSource:JXSegmentedTitleDataSource = {
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.isTitleColorGradientEnabled = false
        dataSource.titleNormalColor = textBlack
        dataSource.titleSelectedColor = textBlue
        dataSource.titleNormalFont = latoBold(18)
        dataSource.titleSelectedFont = latoBold(18)
        dataSource.titles = tabs
        dataSource.reloadData(selectedIndex: 0)
        return dataSource
    }()
    
    @IBAction func menAction(_ sender: UIButton) {
        MenuViewController.showMenu(self.tabs) { (menu, index) in
            self.segmentedView.selectItemAt(index: index)
            self.segmentedListContainerView.didClickSelectedItem(at: index)
        }
    }
    override func viewDidLayoutSubviews() {
        segmentedView.frame = self.tabLayout.bounds
        segmentedListContainerView.frame = self.tabController.bounds
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabLayout.addSubview(segmentedView)
        self.tabController.addSubview(segmentedListContainerView)
    }
}

extension HomeNewsViewController:JXSegmentedListContainerViewDataSource{
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        return newsViewController(codes[index])
    }
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return self.dataSource.dataSource.count
    }
}

extension HomeNewsViewController: JXSegmentedViewDelegate {
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


