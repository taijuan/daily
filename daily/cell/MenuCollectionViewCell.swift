//
//  MenuCollectionViewCell.swift
//  daily
//
//  Created by 郑泰捐 on 2019/12/11.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    private let textLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(){
        self.textLabel.textColor = textBlack
        self.textLabel.font = latoSemibold(20)
        self.textLabel.textAlignment = .center
        self.textLabel.backgroundColor = .white
        self.contentView.addSubview(self.textLabel)
        self.contentView.setViewShadow(borderColor: .clear, cornerRadius: 4)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel.frame = self.contentView.bounds
    }
    
    func refresh(_ menu:String){
        self.textLabel.text = menu
    }
    override var isHighlighted: Bool{
        set {
            super.isSelected = newValue
            self.textLabel.backgroundColor = newValue ? dividerGray : UIColor.white
            LogUtils.info(newValue)
        }
        get {
            return super.isSelected
        }
    }
}
