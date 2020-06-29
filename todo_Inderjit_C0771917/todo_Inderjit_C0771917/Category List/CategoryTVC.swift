//
//  SubjectTVC.swift
//  todo_Inderjit_C0771917
//
//  Created by Inderjit on 24/06/20.
//  Copyright © 2020 Inderjit. All rights reserved.
//

import UIKit
import CoreData

class CategoryTVC: UITableViewCell {
    
    @IBOutlet var subjectLbl: UILabel!
    @IBOutlet weak var editButtonOL: UIButton!
    
    var categoryData: CategoryDB?{
        didSet{
         subjectLbl.text =  "\(categoryData?.title ?? "")"
        }
    }
     
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
