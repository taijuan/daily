//
//  NewsBannerCell.swift
//  daily
//
//  Created by 郑泰捐 on 2019/12/6.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import FSPagerView

class NewsBannerCell:FSPagerViewCell{
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.frame = self.contentView.bounds
        self.selectedBackgroundView?.bounds = self.contentView.bounds
        if self.textLabel != nil{
            var superRect = self.contentView.bounds
            let height:CGFloat = 16+40.0+48
            superRect.size.height = height
            superRect.origin.y = self.contentView.frame.height-height
            self.textLabel!.superview!.frame = superRect
            var textRect = superRect
            textRect.origin.y = 16
            textRect.size.height = 40
            textRect.origin.x = 20
            textRect.size.width = superRect.width - 40
            self.textLabel!.frame = textRect
        }
    }
    
    func refresh(_ data:News){
        self.imageView?.loadImage(data.imageFulUrl())
        self.imageView?.contentMode = .scaleAspectFill
        self.imageView?.clipsToBounds = true
        self.textLabel?.numberOfLines = 2
        self.textLabel?.textColor = textWhite
        self.textLabel?.setText(text: data.title, font: latoBold(18), lineHeight: 20)
        self.textLabel?.superview?.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
}
