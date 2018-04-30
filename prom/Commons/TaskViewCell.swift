//
//  TaskViewCell.swift
//  prom
//
//  Created by Deepak Sharma S M on 4/18/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit

class TaskViewCell: UITableViewCell {

    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskStatus: UILabel!
    @IBOutlet weak var ownerInitials: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
