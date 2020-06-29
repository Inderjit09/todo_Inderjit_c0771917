//
//  TaskTVC.swift
//  todo_Inderjit_C0771917
//
//  Created by Inderjit on 25/06/20.
//  Copyright © 2020 Inderjit. All rights reserved.
//

import UIKit

class TaskTVC: UITableViewCell {
    
   
       @IBOutlet weak var categoryNameLbl: UILabel!
       @IBOutlet weak var taskTitleLbl: UILabel!
       @IBOutlet weak var descLbl: UILabel!
       @IBOutlet weak var timeLbl: UILabel!
       @IBOutlet weak var editBtnAction: UIButton!
     @IBOutlet weak var markCompleteBtnAction: UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
