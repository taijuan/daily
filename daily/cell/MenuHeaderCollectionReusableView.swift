//
//  xx.swift
//  daily
//
//  Created by 郑泰捐 on 2019/12/11.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

class MenuHeaderCollectionReusableView: UICollectionReusableView {
    private lazy var textLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Column"
        label.font = latoBold(24)
        label.textColor = textBlack
        return label
    }()
    
    private lazy var botton : UIButton = {
        let botton = UIButton(type: .custom)
        botton.setImage(UIImage(named: "hk_delete"), for: .normal)
        botton.setTitle("", for: .normal)
        botton.addTarget(self, action: #selector(self.onClick), for: .touchUpInside)
        botton.setBackground(normalColor: .clear, highLightColor: dividerGray)
        return botton
    }()
    
    private lazy var divider:UIView = {
        let divider = UIView()
        divider.backgroundColor = dividerGray
        return divider
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(textLabel)
        self.addSubview(botton)
        self.addSubview(divider)
    }
    override func layoutSubviews() {
        let width = self.bounds.width
        let height = self.bounds.height - 20
        LogUtils.info(height)
        self.textLabel.frame = CGRect(x: 0, y: 0, width: 120, height: height)
        self.botton.frame = CGRect(x: width - height, y: 0, width: height, height: height)
        self.divider.frame = CGRect(x: 20, y: height-1, width: width - 20*2, height:1)
    }
    
    @objc func onClick(){
        UIViewController.current()?.dismiss(animated: false)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
