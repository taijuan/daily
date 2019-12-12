//
//  FavoriteVideoTableViewCell.swift
//  daily
//
//  Created by 郑泰捐 on 2019/12/3.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

class FavoriteVideoTableViewCell: UITableViewCell {
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var codeView: UIView!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    private let titleFont = latoSemibold(16)
    override func awakeFromNib() {
        super.awakeFromNib()
        self.videoView.setViewShadow(borderColor: dividerGray, cornerRadius: 4)
        self.codeView.setViewShadow(borderColor: dividerGray, cornerRadius: 9)
        self.pictureView.contentMode = .scaleAspectFill
        self.titleLabel.textColor = textBlack
        self.codeLabel.textColor = textGray
        self.timeLabel.textColor = textGray
        self.codeLabel.font = latoRegular(12)
        self.timeLabel.font = latoRegular(12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func refresh(_ data:News){
        self.pictureView.loadImage(data.imageFulUrl())
        self.titleLabel.setText(text: data.title, font: titleFont, lineHeight: 20)
        self.codeLabel.text = data.subjectName
        self.timeLabel.text = data.time()
    }

}
