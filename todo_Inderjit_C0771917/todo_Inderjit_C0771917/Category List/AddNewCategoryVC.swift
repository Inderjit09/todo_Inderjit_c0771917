//
//  AddNewcategoryVC.swift
//  todo_Inderjit_C0771917
//
//  Created by Inderjit on 24/06/20.
//  Copyright © 2020 Inderjit. All rights reserved.
//

import UIKit

class AddNewCategoryVC: UIViewController {
    
    // MARK: - Variable
    
    var isEditCategory = Bool()
    var indexRow = Int()
    var categoryDetails: CategoryDB?
    
    // MARK: - Outlets
    @IBOutlet weak var categoryTxtFld: UITextField!
    @IBOutlet weak var addCategoryBtnOL: UIButton!
    
     // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categoryTxtFld.setLeftPaddingPoints(20)
        self.categoryTxtFld.text = categoryDetails?.title

        
        // set button title
        if isEditCategory {
             addCategoryBtnOL.setTitle("Save Category", for: .normal)
        }else{
            addCategoryBtnOL.setTitle("Add Category", for: .normal)
        }
        
    }
    
     // MARK: - Button Action
    @IBAction func AddNewcategoryBtnAction(_ sender: Any) {
        
        let categoryStr  = self.categoryTxtFld.text ?? ""
        if  categoryStr.trim().count > 0 {
            let categoryData = ["categoryName": categoryStr.trim()]
            if isEditCategory {
                DatabaseHelper.shareInstance.editCategoryData(CategoryDict: categoryData, index: indexRow)
                isEditCategory = false
                 
            }else{
                DatabaseHelper.shareInstance.saveCategoryData(CategoryDict: categoryData)
            }
               
             self.navigationController?.popViewController(animated: true)
        } else {
            showAlertDialog(title: "Please Enter Category Name")
        }
    }
    
}
