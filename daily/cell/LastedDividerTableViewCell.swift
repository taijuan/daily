//
//  LastedDividerTableViewCell.swift
//  daily
//
//  Created by 郑泰捐 on 2019/12/3.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

class LastedDividerTableViewCell: UITableViewCell {
    @IBOutlet weak var dividerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dividerView.backgroundColor = dividerGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
