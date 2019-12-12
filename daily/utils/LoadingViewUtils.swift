//
//  LoadingViewUtils.swift
//  daily
//
//  Created by 郑泰捐 on 2019/11/29.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import RxSwift

protocol LoadingViewUtils {
    //MARK:loadingView显示
    func showLoading()
    //MARK:loadingViewx隐藏
    func hideLoading()
}

//MARK:loadingView
class LoadingView :LoadingViewUtils{
    private let loadingVIew: UIActivityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
    private let view:UIView
    required init(_ view:UIView){
        self.view = view
        loadingVIew.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        loadingVIew.color = backgroundBlue
        loadingVIew.backgroundColor = halfTransparent
        loadingVIew.layer.cornerRadius = 8
        self.view.addSubview(loadingVIew)
    }
    
    func showLoading() {
        let bounds = view.bounds
        loadingVIew.center = CGPoint(x: bounds.midX, y: bounds.midY)
        loadingVIew.startAnimating()
    }
    
    func hideLoading() {
        if(loadingVIew.isAnimating){
            loadingVIew.stopAnimating()
        }
    }
}



class LoadingViewController:UIViewController,LoadingViewUtils{
    private let disposeBag = DisposeBag()
    private lazy var loadingView = LoadingView(self.view)

    static func createLoadingDialog()->LoadingViewController{
        let dialog =  LoadingViewController()
        dialog.view.backgroundColor = halfTransparent
        dialog.modalPresentationStyle = .custom
        return dialog
    }
    func showLoading() {
        UIViewController.self.current()?.present(self, animated: false, completion: nil)
        loadingView.showLoading()
    }
    
    func hideLoading() {
        loadingView.hideLoading()
        UIViewController.self.current()?.dismiss(animated: false, completion: nil)
    }
    
    func delayHideLoading(){
        Observable.just(1).delay(DispatchTimeInterval.seconds(10), scheduler: MainScheduler.instance).subscribe(onNext: nil, onError: nil, onCompleted: {
            self.hideLoading()
        }).disposed(by: disposeBag)
    }
}

