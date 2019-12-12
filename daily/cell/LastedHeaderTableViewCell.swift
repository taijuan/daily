//
//  LastedHeaderTableViewCell.swift
//  daily
//
//  Created by 郑泰捐 on 2019/12/2.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

class LastedHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var codeView: UIView!
    
    private let titleFont = latoBold(18)
    private let descFont = latoRegular(14)
    private let codeFont = latoRegular(14)
    private let timeFont = latoRegular(12)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.codeView.setViewShadow(borderWidth: 1, borderColor: dividerGray, cornerRadius: 12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func refresh(_ data : News){
        self.titleLabel.setText(text: data.title, font: titleFont, lineHeight: 24)
        self.descLabel.setText(text: data.description, font: descFont, lineHeight: 24)
        self.codeLabel.setText(text: data.subjectName, font: codeFont, lineHeight: 0)
        self.timeLabel.setText(text: data.time(), font: timeFont, lineHeight: 0)
    }
}
