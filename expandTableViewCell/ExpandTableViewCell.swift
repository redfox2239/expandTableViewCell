//
//  ExpandTableViewCell.swift
//  expandTableViewCell
//
//  Created by HARADA REO on 2015/08/20.
//  Copyright (c) 2015年 reo harada. All rights reserved.
//

import UIKit

class ExpandTableViewCell: UITableViewCell {

    @IBOutlet weak var cellTitleTextLabel: UILabel!
    @IBOutlet weak var cellDetailTextLabel: UILabel!
    @IBOutlet weak var titleLabelWidth: NSLayoutConstraint!
    @IBOutlet weak var detailLabelWidth: NSLayoutConstraint!
    @IBOutlet weak var expandButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func estmateHeight(text: String,detail: String) -> CGFloat {
        self.cellTitleTextLabel.text = text
        self.cellTitleTextLabel.sizeToFit()
        self.cellDetailTextLabel.text = detail
        self.cellDetailTextLabel.sizeToFit()
        self.layoutIfNeeded()
        let height = CGRectGetHeight(self.cellTitleTextLabel.frame)
            + CGRectGetHeight(self.expandButton.frame)
            + CGRectGetHeight(self.cellDetailTextLabel.frame)
            + 20
        return height
    }
}
