//
//  HomeViewController.swift
//  daily
//
//  Created by 郑泰捐 on 2019/11/12.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class HomeViewController: ESTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let home = homeNewsViewController()
        home.tabBarItem = ESTabBarItem(SpringBouncesContentView(),title: "News", image: UIImage(named: "hk_news"),selectedImage: nil)
        let epaper = epaperViewController()
        epaper.tabBarItem = ESTabBarItem(SpringBouncesContentView(),title: "ePaper", image: UIImage(named: "hk_epaper"),selectedImage: nil)
        let me = meViewController()
        me.tabBarItem = ESTabBarItem(SpringBouncesContentView(),title: "Me", image: UIImage(named: "hk_me"),selectedImage: nil)
        viewControllers = [home,epaper,me]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


class SpringBouncesContentView: ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = textBlack
        iconColor = textBlack
        highlightTextColor = textBlue
        highlightIconColor = textBlue
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func selectAnimation(animated: Bool, completion: (() -> ())?) {
        self.bounceAnimation()
        completion?()
    }
    
    override func reselectAnimation(animated: Bool, completion: (() -> ())?) {
        self.bounceAnimation()
        completion?()
    }
    
    func bounceAnimation() {
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        impliesAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        impliesAnimation.duration = 1
        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
        imageView.layer.add(impliesAnimation, forKey: nil)
    }
}
