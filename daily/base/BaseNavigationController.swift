//
//  xx.swift
//  daily
//
//  Created by 郑泰捐 on 2019/11/28.
//  Copyright © 2019 郑泰捐. All rights reserved.
//


import UIKit

class BaseNavigationController: UINavigationController {

    override var preferredInterfaceOrientationForPresentation : UIInterfaceOrientation {
        return .portrait
    }
    
    /// 重写此方法让 preferredStatusBarStyle 响应
    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: 解决右滑返回失效问题
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}

extension BaseNavigationController:UIGestureRecognizerDelegate{
    //MARK:这个方法是在手势将要激活前调用：返回YES允许右滑手势的激活，返回NO不允许右滑手势的激活
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.interactivePopGestureRecognizer {
            //MARK:屏蔽调用rootViewController的滑动返回手势，避免右滑返回手势引起死机问题
            if self.viewControllers.count < 2 || self.visibleViewController == self.viewControllers.first {
                return false
            }
        }
        return true
    }
}


/*
 导航栏各种右滑返回失效的解决方法：
 //https://www.jianshu.com/p/2b2be863bb79
 //https://juejin.im/post/5adeda3051882567336a5dc9
 */
