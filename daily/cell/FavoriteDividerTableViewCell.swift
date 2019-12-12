//
//  FavoriteDividerTableViewCell.swift
//  daily
//
//  Created by 郑泰捐 on 2019/12/3.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

class FavoriteDividerTableViewCell: UITableViewCell {
    @IBOutlet weak var divider: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.divider.backgroundColor = dividerGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
