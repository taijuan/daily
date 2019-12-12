//
//  ShareViewController.swift
//  daily
//
//  Created by 郑泰捐 on 2019/12/11.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {
    private let names = ["Facebook","Twitter","LinkedIn","Instagram","Snapchat","Wechat","Moments"]
    private let icons = ["share_facebook","share_twitter","share_linkedin","share_instagram","share_snapchat","share_wechat","share_moments"]
    private lazy var layout:UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        return layout
    }()
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            self.collectionView.collectionViewLayout = self.layout
            self.collectionView.dataSource = self
            self.collectionView.setViewShadow(borderColor: .clear)
            self.collectionView.register(ShareCollectionViewCell.self, forCellWithReuseIdentifier: "ShareCollectionViewCell")
        }
    }
    @IBOutlet weak var cancelBtn: UIButton!{
        didSet{
            self.cancelBtn.setBackground()
            self.cancelBtn.setViewShadow(borderColor: .clear)
            self.cancelBtn.titleLabel?.font = latoSemibold(18)
            self.cancelBtn.setTitleColor(textBlue, for: .normal)
            self.cancelBtn.setTitleColor(textBlue, for: .highlighted)
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        NotificationCenter.default.addObserver(self, selector:#selector(handleDeviceOrientationDidChange(interfaceOrientation:)), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    override func viewDidLayoutSubviews() {
        //横屏时, 跳转页面
        if UIApplication.shared.statusBarOrientation.isLandscape {
            let cellWidth = (UIScreen.main.bounds.size.width - 10*2 - 19*2 - 23*5)/6
            let cellHeight = cellWidth+20
            self.layout.scrollDirection = .horizontal
            self.layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
            self.layout.sectionInset = UIEdgeInsets(top: 24, left: 19, bottom: 24, right: 19)
            self.layout.minimumLineSpacing = 23
            self.layout.minimumInteritemSpacing = 23
            var rect = self.collectionView.frame
            let oldHeight = rect.height
            let height = cellHeight + 24*2
            rect.origin.y = rect.origin.y+oldHeight-height
            rect.size.height = height
            self.collectionView.frame = rect
            self.collectionView.reloadData()
        }
        //竖屏时,退出页面
        else {
            let cellWidth = (UIScreen.main.bounds.size.width - 10*2 - 19*2 - 23*3)/4
            let cellHeight = cellWidth+20
            self.layout.scrollDirection = .vertical
            self.layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
            self.layout.sectionInset = UIEdgeInsets(top: 24, left: 19, bottom: 24, right: 19)
            self.layout.minimumLineSpacing = 23
            self.layout.minimumInteritemSpacing = 23
            var rect = self.collectionView.frame
            let oldHeight = rect.height
            let height = cellHeight*2 + 24*2 + 23 - 1
            rect.origin.y = rect.origin.y+oldHeight-height
            rect.size.height = height
            self.collectionView.frame = rect
            self.collectionView.reloadData()
        }
        
    }
    //MARK:2.手机更改屏幕方向后发送通知, 跳转到页面
    @objc private func handleDeviceOrientationDidChange(interfaceOrientation: UIInterfaceOrientation){
        viewDidLayoutSubviews()
    }
    
    //MARK:3.移除通知
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK:显示
    class func show(title:String,desc:String,imageUrl:String,webUrl:String){
        let share = UIStoryboard.init(name: "share",bundle: nil).instantiateViewController(withIdentifier: "ShareViewController") as! ShareViewController
        share.modalPresentationStyle = .custom
        UIViewController.current()?.present(share, animated: false)
    }
    
    //MARL:取消
    func dismiss(){
        self.dismiss(animated: false)
    }
}

extension ShareViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ShareCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShareCollectionViewCell", for: indexPath) as!ShareCollectionViewCell
        let index = indexPath.row
        cell.refresh(self.names[index], self.icons[index])
        return cell
    }
}
