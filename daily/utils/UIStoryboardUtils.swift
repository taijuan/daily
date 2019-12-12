//
//  UIStoryboardUtils.swift
//  daily
//
//  Created by 郑泰捐 on 2019/11/21.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

//MARK:UIStoryboard初始化
fileprivate func uiStoryboard(_ name:String = "Main") -> UIStoryboard{
    return UIStoryboard.init(name: "Main",bundle: nil)
}

//MARK:使用UIStoryboard生成ViewController
fileprivate func instantiateViewController<T>(_ withIdentifier:String) ->T {
    return uiStoryboard().instantiateViewController(withIdentifier: withIdentifier) as! T
}

//MARK:主页ViewController
func homeViewController() -> BaseNavigationController{
    let home :HomeViewController = instantiateViewController("HomeViewController")
    let navi = BaseNavigationController(rootViewController: home)
    navi.navigationBar.isHidden = true
    return navi
}

func homeNewsViewController() -> HomeNewsViewController{
    let homeNews:HomeNewsViewController = instantiateViewController("HomeNewsViewController")
    return homeNews
}

func epaperViewController() -> EpaperViewController{
    let epaper:EpaperViewController = instantiateViewController("EpaperViewController")
    return epaper
}

func meViewController() -> MeViewController{
    let me:MeViewController = instantiateViewController("MeViewController")
    return me
}

func favoriteTableViewController(_ code:String) ->FavoriteTableViewController{
    let controller : FavoriteTableViewController = instantiateViewController("FavoriteTableViewController")
    controller.setCode(code)
    return controller
}

func newsViewController(_ code:String) -> NewsTableViewController{
    let controller : NewsTableViewController = instantiateViewController("NewsTableViewController")
    controller.setCode(code)
    return controller
}


func newsDetailViewController(_ dataId:String)->NewsDetailViewController{
    let controller : NewsDetailViewController = instantiateViewController("NewsDetailViewController")
    controller.setDataId(dataId)
    return controller
}

func videoDetailViewController(_ dataId:String)->VideoDetailViewController{
    let controller : VideoDetailViewController = instantiateViewController("VideoDetailViewController")
    controller.setDataId(dataId)
    return controller
}

func webViewController(_ title:String,_ url:String)->WebViewController{
    let controller : WebViewController = instantiateViewController("WebViewController")
    controller.setTitle(title)
    controller.setUrl(url)
    return controller
}

func settingsViewController()->SettingsViewController{
    let controller : SettingsViewController = instantiateViewController("SettingsViewController")
    return controller
}

func aboutUsViewController()->AboutUsViewController{
    let controller : AboutUsViewController = instantiateViewController("AboutUsViewController")
    return controller
}

func contactUsViewController()->ContactUsViewController{
    let controller : ContactUsViewController = instantiateViewController("ContactUsViewController")
    return controller
}

extension UIViewController {
    class func current(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return current(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return current(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return current(base: presented)
        }
        return base
    }
}
