//
//  CategoryListVC.swift
//  todo_Inderjit_C0771917
//
//  Created by Inderjit on 24/06/20.
//  Copyright © 2020 Inderjit. All rights reserved.
//

import UIKit

protocol categoryDataPass {
    
    func passCategoryData(categorytitle:String)
}

class CategoryListVC: UIViewController {
    
    //MARK:- Variable
    var Categorys = [CategoryDB]()
    var delegate :categoryDataPass?
    
    //MARK:- OutLets
    @IBOutlet weak var categoryTblView: UITableView!
    
     //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.Categorys = DatabaseHelper.shareInstance.getAllCategoryData()
        self.categoryTblView.reloadData()
        self.categoryTblView.tableFooterView = UIView()
    }
}

// MARK: - Table view Delegate & Datasource

extension CategoryListVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Categorys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTVC", for: indexPath) as! CategoryTVC
        cell.categoryData = Categorys[indexPath.row]
        
        cell.editButtonOL.tag = indexPath.row
        cell.editButtonOL.addTarget(self, action: #selector(self.btnCheck(_:)), for: .touchUpInside)
        
        cell.selectionStyle = .none
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         self.navigationController?.popViewController(animated: true)
        self.delegate?.passCategoryData(categorytitle: Categorys[indexPath.row].title ?? "")
        
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.Categorys = DatabaseHelper.shareInstance.deleteCategoryData(index: indexPath.row)
            self.categoryTblView.deleteRows(at: [indexPath], with: .top)
        }
    }
    
    @objc func btnCheck(_ sender: UIButton) {
        
        let CategoryDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewCategoryVC") as! AddNewCategoryVC
        CategoryDetailVC.categoryDetails = Categorys[sender.tag]
        CategoryDetailVC.indexRow = sender.tag
        CategoryDetailVC.isEditCategory = true
        self.navigationController?.pushViewController(CategoryDetailVC, animated: true)
        
    }
}
