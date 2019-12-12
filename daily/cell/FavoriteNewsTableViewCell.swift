//
//  FavoriteNewsTableViewCell.swift
//  daily
//
//  Created by 郑泰捐 on 2019/12/3.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

class FavoriteNewsTableViewCell: UITableViewCell {
    @IBOutlet weak var pictureVIew: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var codeView: UIView!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    private let titleFont = latoRegular(14)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.codeView.setViewShadow(borderWidth: 1, borderColor: dividerGray, cornerRadius: 9)
        self.pictureVIew.contentMode = .scaleAspectFill
        self.pictureVIew.setViewShadow(borderWidth: 1, borderColor: dividerGray, cornerRadius: 4)
        self.pictureVIew.contentMode = .scaleAspectFill
        self.titleLabel.textColor = textBlack
        self.codeLabel.textColor = textGray
        self.codeLabel.font = latoRegular(12)
        self.timeLabel.textColor = textGray
        self.timeLabel.font = latoRegular(12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func refresh(_ data:News){
        self.pictureVIew.loadImage(data.imageFulUrl())
        self.titleLabel.setText(text: data.title, font: titleFont, lineHeight: 20)
        self.codeLabel.text = data.subjectName
        self.timeLabel.text = data.time()
    }
}
