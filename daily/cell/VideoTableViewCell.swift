//
//  VideoTableViewCell.swift
//  daily
//
//  Created by 郑泰捐 on 2019/11/27.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var codeContainer: UIView!
    @IBOutlet weak var codeLabel: UILabel!
    
    private let titleFont = latoSemibold(16)
    private let codeFont = latoRegular(12)
    private let timeFont = latoRegular(12)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.container.setViewShadow(borderWidth: 1, borderColor: dividerGray, cornerRadius: 9)
        self.pictureView.contentMode = .scaleAspectFill
        self.titleLabel.textColor = textBlack
        self.codeContainer.setViewShadow(borderWidth: 1, borderColor: dividerGray, cornerRadius: 9)
        self.codeLabel.textColor = textGray
        self.timeLabel.textColor = textGray
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func refresh(_ data : News){
        self.pictureView.loadImage(data.imageFulUrl())
        self.titleLabel.setText(text: data.title, font: titleFont, lineHeight: 20)
        self.codeLabel.setText(text: data.subjectName, font: codeFont, lineHeight: 0)
        self.timeLabel.setText(text: data.time(), font: timeFont, lineHeight: 0)
    }
    
}
