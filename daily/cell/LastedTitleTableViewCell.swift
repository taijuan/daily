//
//  LastedTitleTableViewCell.swift
//  daily
//
//  Created by 郑泰捐 on 2019/12/2.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

class LastedTitleTableViewCell: UITableViewCell {
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleView.backgroundColor = dividerGray
        self.titleLabel.setText(text: "Latest", font: latoSemibold(18), lineHeight: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
