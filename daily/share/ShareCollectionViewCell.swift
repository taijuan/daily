//
//  ShareCollectionViewCell.swift
//  daily
//
//  Created by 郑泰捐 on 2019/12/12.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

class ShareCollectionViewCell: UICollectionViewCell {
    private lazy var iconView:UIImageView = {
        let image = UIImageView()
        self.contentView.addSubview(image)
        return image
    }()
    private lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.font = latoRegular(12)
        label.textColor = textBlack
        label.textAlignment = .center
        self.contentView.addSubview(label)
        return label
    }()
    
    override func layoutSubviews() {
        //MARK:必须要要添加super.layoutSubviews()，不然横竖屏切换有问题
        super.layoutSubviews()
        let width = self.contentView.bounds.width
        let height = self.contentView.bounds.height
        self.iconView.frame = CGRect(x: 0, y: 0, width: width, height: width)
        self.nameLabel.frame = CGRect(x: 0, y: width, width: width, height: height - width)
    }
    
    override var isHighlighted: Bool{
        set {
            super.isSelected = newValue
            self.contentView.backgroundColor = newValue ? dividerGray : UIColor.white
            LogUtils.info(newValue)
        }
        get {
            return super.isSelected
        }
    }
    func refresh(_ name:String,_ icon:String){
        self.nameLabel.text = name
        self.iconView.image = UIImage(named: icon)
    }
}
