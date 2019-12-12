//
//  FocusHeaderTableViewCell.swift
//  daily
//
//  Created by 郑泰捐 on 2019/11/27.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import FSPagerView

class FocusHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var pageContainer: UIView!
    @IBOutlet weak var pageControlContainer: UIView!
    
    private lazy var pageView = FSPagerView()
    private lazy var pageControl = FSPageControl()
     
    private var focusData : [News] = []
    
    override func awakeFromNib() {
        self.pageContainer.addSubview(pageView)
        self.pageControlContainer.addSubview(pageControl)
        self.pageView.isInfinite = true
        self.pageView.register(NewsBannerCell.self, forCellWithReuseIdentifier: "FSPagerViewCell")
        self.pageView.dataSource = self
        self.pageView.delegate = self
        self.pageContainer.setViewShadow(borderColor:.clear)
        self.pageControl.itemSpacing = 8
        self.pageControl.interitemSpacing = 8
        self.pageControl.setFillColor(textWhite, for: .normal)
        self.pageControl.setFillColor(textGray, for: .selected)
        self.pageControl.contentHorizontalAlignment = .right
//        //MARK:1.监测手机横屏的通知
//        NotificationCenter.default.addObserver(self, selector: #selector(handleDeviceOrientationDidChange(interfaceOrientation:)), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.pageView.itemSize = self.pageContainer.bounds.size
        self.pageView.frame = self.pageContainer.bounds
        self.pageControl.frame = self.pageControlContainer.bounds
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func refresh(_ data:[News]){
        self.focusData = data
        self.pageControl.numberOfPages = self.focusData.count
        self.pageView.reloadData()
    }

//    //MARK:2.手机更改屏幕方向后发送通知, 跳转到页面
//    @objc func handleDeviceOrientationDidChange(interfaceOrientation: UIInterfaceOrientation){
//        let device = UIDevice.current
//        //横屏时, 跳转页面
//        if device.orientation == .landscapeLeft || device.orientation == .landscapeRight{
//            layoutSubviews()
//        }
//        //竖屏时,退出页面
//        if device.orientation == .portrait || device.orientation == .portraitUpsideDown{
//            layoutSubviews()
//        }
//    }
//
//    //MARK:3.移除通知
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
}

//MARK: dataSource
extension FocusHeaderTableViewCell : FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.focusData.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell:NewsBannerCell = pagerView.dequeueReusableCell(withReuseIdentifier: "FSPagerViewCell", at: index) as! NewsBannerCell
        cell.refresh(self.focusData[index])
        return cell
    }
}

extension FocusHeaderTableViewCell : FSPagerViewDelegate {
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        UIViewController.current()?.navigationController?.pushViewController(newsDetailViewController(focusData[index].dataId), animated: true)
    }
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
        
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
    }
}


