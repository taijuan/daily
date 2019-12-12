//
//  MenuViewController.swift
//  daily
//
//  Created by 郑泰捐 on 2019/12/10.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import JXBottomSheetView

class MenuViewController: UIViewController {
    private var menus = Array<String>()
    private var delegate:MenuDelegate?
    private lazy var bottomSheet:JXBottomSheetView = {
        let bottomSheet = JXBottomSheetView(contentView: self.collectionView)
        bottomSheet.defaultMininumDisplayHeight = 0
        bottomSheet.defaultMaxinumDisplayHeight = 600
        bottomSheet.frame = self.view.bounds
        bottomSheet.displayState = .maxDisplay
        bottomSheet.triggerDistance = 250
        bottomSheet.delegate = self
        self.view.addSubview(bottomSheet)
        return bottomSheet
    }()
    private lazy var collectionView:UICollectionView = {
        //创建布局对象
        let flowLayout = JYEqualCellSpaceFlowLayout(.left)
        let width = (UIScreen.main.bounds.size.width - 4*20)/3
        //设置item的大小
        flowLayout.itemSize = CGSize(width: width, height: 46)
        //设置滚动的方向  horizontal水平混动
        flowLayout.scrollDirection = .vertical
        //设置最小行间距
        flowLayout.minimumLineSpacing = 20
        //设置最小列间距
        flowLayout.minimumInteritemSpacing = 20
        //设置分区缩进量
        flowLayout.sectionInset = .zero
        //设置区头的大小
        flowLayout.headerReferenceSize = .zero
        flowLayout.footerReferenceSize = .zero
        let view = UICollectionView(frame:.zero,collectionViewLayout:flowLayout)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.cornerRadius = 16
        view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        view.register(MenuHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MenuHeaderCollectionReusableView")
        view.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: "MenuCollectionViewCell")
        view.register(MenuFooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "MenuFooterCollectionReusableView")
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    func setMenus(_ menus:Array<String>){
        self.menus = menus
    }
    func setDelegate(delegate:@escaping MenuDelegate){
        self.delegate = delegate
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }
    

    override func viewDidLayoutSubviews() {
        self.bottomSheet.frame = self.view.bounds
    }
    
    class func showMenu(_ menus:Array<String>,delegate:@escaping MenuDelegate){
        let menu = MenuViewController()
        menu.setMenus(menus)
        menu.setDelegate(delegate: delegate)
        menu.modalPresentationStyle = .custom
        UIViewController.current()?.present(menu, animated: false)
    }
    func dismiss(){
        self.dismiss(animated: false)
    }
}

extension MenuViewController:UICollectionViewDataSource{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:MenuCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath) as!MenuCollectionViewCell
        cell.refresh(self.menus[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       var reusableview : UICollectionReusableView = UICollectionReusableView()
        if (kind == UICollectionView.elementKindSectionHeader){
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MenuHeaderCollectionReusableView", for: indexPath)
            reusableview = headerView
        }
        if (kind == UICollectionView.elementKindSectionFooter){
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "MenuFooterCollectionReusableView", for: indexPath)
            reusableview = footerView
        }
        return reusableview
    }
}
extension MenuViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?(self.menus[indexPath.row],indexPath.row)
        self.dismiss()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60)
    }
}
extension MenuViewController:JXBottomSheetViewDelegate{
    func bottomSheet(bottomSheet: JXBottomSheetView, didDisplayed state: JXBottomSheetState) {
        if state == .minDisplay{
            self.dismiss()
        }
    }
}

typealias MenuDelegate = (_ menu:String,_ index:Int)-> Void
