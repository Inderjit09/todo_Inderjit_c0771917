//
//  TaskListVC.swift
//  todo_Inderjit_C0771917
//
//  Created by Inderjit on 25/06/20.
//  Copyright © 2020 Inderjit. All rights reserved.
//

import UIKit
import CoreData

class TaskListVC : UIViewController,UISearchBarDelegate {
    
    //MARK:- Variable
    var Tasks = [TaskDB]()
    var searchString = String()
    
      // var delegate :subjectDataPass?
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var searchbarheight: NSLayoutConstraint!
    @IBOutlet weak var listSearchBar: UISearchBar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       
    }
    override func viewWillAppear(_ animated: Bool) {
        self.Tasks = DatabaseHelper.shareInstance.getAllCompletedTasksData(value:false)
        self.tblView.reloadData()
        self.tblView.tableFooterView = UIView()
        
        self.tblView.rowHeight = UITableView.automaticDimension;
        self.tblView.estimatedRowHeight = 44.0;
        listSearchBar.delegate = self
        listSearchBar.text = ""
        
        if self.Tasks.count > 0 {
            self.searchbarheight.constant = 100
        }else{
            self.searchbarheight.constant = 0
        }
        
       }

    @IBAction func sortingAction(_ sender: Any) {
        
        if (sender as AnyObject).selectedSegmentIndex == 0 {
            
            self.Tasks = DatabaseHelper.shareInstance.GetSortedData(sortTxt: "title")
            self.tblView.reloadData()
            
        }else{
            self.Tasks = DatabaseHelper.shareInstance.GetSortedData(sortTxt: "time")
            self.tblView.reloadData()
            
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
        
        searchString = searchText
        
        if searchText != "" {
            self.Tasks = DatabaseHelper.shareInstance.GetFilteredData(searchText:searchText)
        }else{
            self.Tasks = DatabaseHelper.shareInstance.getAllCompletedTasksData(value:false)
        }
        
        
        self.tblView.reloadData()
        self.tblView.tableFooterView = UIView()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
    
        self.Tasks = DatabaseHelper.shareInstance.getAllCompletedTasksData(value:false)
        self.tblView.reloadData()
        self.tblView.tableFooterView = UIView()
    }

}


// MARK: - Table view Delegate & Datasource

extension TaskListVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTVC", for: indexPath) as! TaskTVC
        cell.categoryNameLbl.text = "Category : \(String(describing: Tasks[indexPath.row].category!))"
        cell.taskTitleLbl.text = "Title : \(String(describing: Tasks[indexPath.row].title!))"
        cell.timeLbl.text = "Time : \(String(describing: Tasks[indexPath.row].time!.dateString()))"
        cell.descLbl.text = "\(String(describing: Tasks[indexPath.row].desc!))"
        
        
        cell.categoryNameLbl.textColor = .white
        cell.taskTitleLbl.textColor = .white
        cell.timeLbl.textColor = .white
        cell.descLbl.textColor = .white
        
        if Tasks[indexPath.row].time! > Date() {
            cell.contentView.backgroundColor = .green
        }else{
            cell.contentView.backgroundColor = .red
        }
        
    
        cell.editBtnAction.tag = indexPath.row
        cell.editBtnAction.addTarget(self, action: #selector(self.btnCheck(_:)), for: .touchUpInside)
        
        cell.markCompleteBtnAction.tag = indexPath.row
        cell.markCompleteBtnAction.addTarget(self, action: #selector(self.markComnplete(_:)), for: .touchUpInside)
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // self.navigationController?.popViewController(animated: true)
        //self.delegate?.passSubjectData(subjecttitle: Subjects[indexPath.row].title ?? "")
        
    }
    
    @objc func markComnplete(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Move to Archived", message: "Are you sure?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Move", style: .default) { (action) in
            
            
            let newTaskDict : [String : Any] = ["title":self.Tasks[sender.tag].title!,"desc":self.Tasks[sender.tag].desc!,
                                                "category":self.Tasks[sender.tag].category!,"completed" : true,
                                                "time" : self.Tasks[sender.tag].time!]
            
          
            DatabaseHelper.shareInstance.editTasksData(TasksDict: newTaskDict, index: sender.tag,searchText : self.searchString)
        
            
            let editTasksVC = self.storyboard?.instantiateViewController(withIdentifier: "ArchivedVC") as! ArchivedVC
            self.navigationController?.pushViewController(editTasksVC, animated: true)
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        noAction.setValue(UIColor.red, forKey: "titleTextColor")
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.Tasks = DatabaseHelper.shareInstance.deleteTasksData(index: indexPath.row)
            self.tblView.deleteRows(at: [indexPath], with: .top)
            
            if self.Tasks.count > 0 {
                self.searchbarheight.constant = 100
            }else{
                self.searchbarheight.constant = 0
            }
        }
    }
    
    @objc func btnCheck(_ sender: UIButton) {
        let editTasksVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        editTasksVC.editindexRow = sender.tag
        editTasksVC.taskDetail = self.Tasks[sender.tag]
        editTasksVC.sendingSearchString = searchString
        editTasksVC.isEditTasks = true
        self.navigationController?.pushViewController(editTasksVC, animated: true)
        
    }
}
