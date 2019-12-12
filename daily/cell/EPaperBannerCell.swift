//
//  EPaperBannerCell.swift
//  daily
//
//  Created by 郑泰捐 on 2019/12/6.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import FSPagerView

class EPaperBannerCell:FSPagerViewCell{
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initView()
    }
    func initView(){
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        self.contentView.layer.shadowColor = UIColor.clear.cgColor
        self.contentView.layer.shadowRadius = 5
        self.contentView.layer.shadowOpacity = 0.75
        self.contentView.layer.shadowOffset = .zero
        self.imageView?.backgroundColor = .white
        self.imageView?.setViewShadow(borderColor: dividerGray, cornerRadius: 8)
        self.textLabel?.superview?.backgroundColor = backgroundBlue
        self.textLabel?.superview?.setViewShadow(borderColor: dividerGray, cornerRadius: 4)
        self.textLabel?.font = latoBold(20)
        self.textLabel?.textColor = .white
        self.textLabel?.textAlignment = .center
    }
    override func layoutSubviews() {
        let width = self.contentView.bounds.width
        let imageHeight = width*400/315
        self.imageView?.frame = CGRect(x: 0, y: 0, width: width, height: imageHeight)
        self.textLabel?.superview?.frame = CGRect(x: 0, y: imageHeight+20, width: width, height: 50)
        self.textLabel?.frame = CGRect(x: 0, y: 0, width: width, height: 50)
    }
    func refresh(_ data:EPaper){
        self.imageView?.loadImage(data.imageUrl)
        self.imageView?.contentMode = .scaleAspectFit
        self.textLabel?.text = data.publicationName
    }
}
