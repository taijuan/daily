//
//  EpaperViewController.swift
//  daily
//
//  Created by 郑泰捐 on 2019/11/27.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import FSPagerView
import RxSwift
class EpaperViewController: BaseViewController {
    @IBOutlet weak var pagerView: FSPagerView!{
        didSet{
            self.pagerView.register(EPaperBannerCell.self, forCellWithReuseIdentifier: "FSPagerViewCell")
            self.pagerView.dataSource = self
            self.pagerView.delegate = self
            self.pagerView.interitemSpacing = 30
            self.pagerView.isInfinite = true
        }
    }
    @IBOutlet weak var timeLabel: UILabel!
    
    private lazy var  loadingDialog = LoadingView(self.pagerView)
    private let ePaperViewModel = EPaperViewModel()
    private var data = Array<EPaper>()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timeLabel.textColor = textBlack
        self.timeLabel.setText(text: monthDayYearFromNow(), font: latoBold(36), lineHeight: 42)
        self.loadingDialog.showLoading()
        self.ePaperViewModel.data.observeOn(MainScheduler.instance).subscribe(onNext: { (result) in
            switch result {
            case .none:break
            case .error(_): break
            case .refreshError(_):break
            case .loadMoreError(_):break
            case .success(let success):
                self.data = success
                self.pagerView.reloadData()
                break
            case .refreshSuccess(_):break
            case .loadMoreSuccess(_):break
            }
            self.loadingDialog.hideLoading()
        }).disposed(by: disposeBag)
        self.ePaperViewModel.loadData()
    }
    override func viewDidLayoutSubviews() {
        self.pagerView.itemSize = CGSize(width: self.pagerView.bounds.width - 120, height: self.pagerView.bounds.height)
    }
}
extension EpaperViewController:FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.data.count
    }
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell:EPaperBannerCell = pagerView.dequeueReusableCell(withReuseIdentifier: "FSPagerViewCell", at: index) as! EPaperBannerCell
        cell.refresh(self.data[index])
        return cell
    }
}

extension EpaperViewController : FSPagerViewDelegate {
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        self.navigationController?.pushViewController(webViewController("ePaper", self.data[index].htmlUrl), animated: true)
    }
    
}
