//
//  ViewController.swift
//  todo_Inderjit_C0771917
//
//  Created by Inderjit on 25/06/20.
//  Copyright © 2020 Inderjit. All rights reserved.
//

import UIKit

import UIKit
import CoreData


class ViewController: UIViewController,categoryDataPass{
    
    
    
    //MARK:- Variable
    
    var taskDetail: TaskDB?
    var isEditTasks = Bool()
    var sendingSearchString = String()
    var editindexRow = Int()
    
    var taskDateTime = Date()
   
     //MARK:- Outlets
    @IBOutlet weak var categoryTitleLbl: UILabel!
    @IBOutlet weak var dateTimeLbl: UILabel!
    @IBOutlet weak var taskTitleTxtFld: UITextField!
    @IBOutlet weak var taskDescTxtView: UITextView!
    
    //MARK:- View life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        taskTitleTxtFld.setLeftPaddingPoints(15)
        
        if isEditTasks {
            self.categoryTitleLbl.text = taskDetail?.category ?? "Select Category"
            self.taskTitleTxtFld.text = taskDetail?.title ?? ""
            self.taskDescTxtView.text = taskDetail?.desc ?? ""
            self.dateTimeLbl.text = taskDetail?.time?.dateString()
            self.taskDateTime = taskDetail?.time ?? Date()
            
        }else{
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
      self.view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true);
    }
 /*==================================================================================================================================*/
    
    @IBAction func saveTask(_ sender: Any) {
        
        let categoryStr  = self.categoryTitleLbl.text ?? "Subject"
        let taskTitleStr  = self.taskTitleTxtFld.text ?? ""
        let taskDescStr  = self.taskDescTxtView.text ?? ""
        
        
        if categoryStr.trim() == "Category"  {
            showAlertDialog(title: "Please Select Category")
        }
        else if taskTitleStr.trim().count == 0  {
            showAlertDialog(title: "Please Enter Task title")
        }
        else if taskDescStr.trim().count == 0  {
            showAlertDialog(title: "Please Enter Task Description")
        }
        else{
            
        
            let newTaskDict : [String : Any] = ["title":taskTitleStr,"desc":taskDescStr,
                                                 "category":categoryStr,"completed" : false,
                                                 "time" : self.taskDateTime]
            
            if isEditTasks {
                DatabaseHelper.shareInstance.editTasksData(TasksDict: newTaskDict, index: editindexRow,searchText : sendingSearchString)
                isEditTasks = false
                 
            }else{
                DatabaseHelper.shareInstance.saveTasksData(TasksDict: newTaskDict)
                
                
                let notification = UILocalNotification()
                notification.fireDate = self.taskDateTime
                notification.alertBody = taskTitleStr
                notification.hasAction = true
                UIApplication.shared.scheduleLocalNotification(notification)
                        
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
     //MARK:- Button Action
    @IBAction func setCategoryTitleBtnAction(_ sender: Any) {
        let CategoryDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "CategoryListVC") as! CategoryListVC
        CategoryDetailVC.delegate = self
        self.navigationController?.pushViewController(CategoryDetailVC, animated: true)
    }
    
    @IBAction func setDateTimeBtnAction(_ sender: Any) {
        // Simple Date and Time Picker
           RPicker.selectDate(title: "Select Date & Time", cancelText: "Cancel", datePickerMode: .dateAndTime, minDate: Date(), maxDate: Date().dateByAddingYears(5), didSelectDate: {[weak self] (selectedDate) in
               // TODO: Your implementation for date
               self?.dateTimeLbl.text = selectedDate.dateString()
            
            self!.taskDateTime = selectedDate
           })
    }
    
    
    func passCategoryData(categorytitle: String) {
        categoryTitleLbl.text = "\(categorytitle)"
    }    
}


