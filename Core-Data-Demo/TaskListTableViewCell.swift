//
//  TaskListTableViewCell.swift
//  Core-Data-Demo
//
//  Created by Jennifer A Sipila on 4/30/17.
//  Copyright © 2017 Jennifer A Sipila. All rights reserved.
//

import UIKit

class TaskListTableViewCell: UITableViewCell {

    @IBOutlet weak var taskLabel: UILabel! //Drag an outlet from the task name label in your cell in storyboard to this class. Call it taskLabel. 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
