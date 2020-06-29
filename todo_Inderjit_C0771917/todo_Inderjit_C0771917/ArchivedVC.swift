//
//  ArchivedVC.swift
//  todo_Inderjit_C0771917
//
//  Created by Inderjit on 26/06/20.
//  Copyright © 2020 Inderjit. All rights reserved.
//

import UIKit

class ArchivedVC: UIViewController {
    
    //MARK:- Variable
    var Tasks = [TaskDB]()
     
       
        
    @IBOutlet weak var tblView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.Tasks = DatabaseHelper.shareInstance.getAllCompletedTasksData(value:true)
        self.tblView.reloadData()
        self.tblView.tableFooterView = UIView()
               
        self.tblView.rowHeight = UITableView.automaticDimension;
        self.tblView.estimatedRowHeight = 44.0;
        // Do any additional setup after loading the view.
    }

}


// MARK: - Table view Delegate & Datasource

extension ArchivedVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTVC", for: indexPath) as! TaskTVC
        cell.categoryNameLbl.text = "Category : \(String(describing: Tasks[indexPath.row].category!))"
        cell.taskTitleLbl.text = "Title : \(String(describing: Tasks[indexPath.row].title!))"
        cell.timeLbl.text = "Time : \(String(describing: Tasks[indexPath.row].time!.dateString()))"
        cell.descLbl.text = "\(String(describing: Tasks[indexPath.row].desc!))"
        
        
        cell.editBtnAction.isHidden = true
        cell.markCompleteBtnAction.isHidden = true
        
        cell.selectionStyle = .none
        return cell
    }
    
}
