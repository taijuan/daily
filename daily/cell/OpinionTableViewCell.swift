//
//  OpinionTableViewCell.swift
//  daily
//
//  Created by 郑泰捐 on 2019/11/27.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

class OpinionTableViewCell: UITableViewCell {

    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    private let titleFont = latoBold(14)
    private let timeFont = latoRegular(12)
    override func awakeFromNib() {
        super.awakeFromNib()
        self.pictureView.contentMode = .scaleAspectFill
        self.pictureView.setViewShadow(borderColor:dividerGray,cornerRadius:55)
        self.titleLabel.textColor = textBlack
        self.timeLabel.textColor = textGray
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func refresh(_ data : News){
        self.pictureView.loadImage(data.imageFulUrl())
        self.titleLabel.setText(text: data.title, font: titleFont, lineHeight: 20)
        self.timeLabel.setText(text: data.time(), font: timeFont, lineHeight: 0)
    }
}
