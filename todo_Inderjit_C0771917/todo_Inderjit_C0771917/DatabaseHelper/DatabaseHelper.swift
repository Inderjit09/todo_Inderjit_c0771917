//
//  AppDelegate.swift
//  todo_Inderjit_C0771917
//
//  Created by Inderjit on 25/06/20.
//  Copyright © 2020 Inderjit. All rights reserved.
//

import UIKit
import CoreData

class DatabaseHelper: NSObject {

    static let shareInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK:-  TaskDB Methods
    
    func saveTasksData(TasksDict: [String:Any]){
        let Tasks = NSEntityDescription.insertNewObject(forEntityName: "TaskDB", into: context) as! TaskDB
        Tasks.title = TasksDict["title"] as? String ?? ""
        Tasks.desc = TasksDict["desc"] as? String ?? ""
        Tasks.time = TasksDict["time"] as? Date ?? Date()
        Tasks.completed = TasksDict["completed"] as? Bool ?? false
        Tasks.category = TasksDict["category"] as? String ?? ""
        
        do{
            try context.save()
        }catch let err{
            print("Tasks save error :- \(err.localizedDescription)")
        }
    }
     
    func getAllCompletedTasksData(value:Bool) -> [TaskDB]{
        var arrTasks = [TaskDB]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TaskDB")
        fetchRequest.predicate = NSCompoundPredicate(type: .or, subpredicates:[
               NSPredicate(format: "completed == %i", value ? 1 : 0)])
        
        do{
            arrTasks = try context.fetch(fetchRequest) as! [TaskDB]
        }catch let err{
            print("Error in Category fetch :- \(err.localizedDescription)")
        }
        return arrTasks
    }
    
    
    
    func deleteTasksData(index: Int) -> [TaskDB]{
        var TasksData = self.getAllCompletedTasksData(value:false) // GetData
        context.delete(TasksData[index]) // Remove From Coredata
        TasksData.remove(at: index) // Remove in array Tasks
        do{
            try context.save()
        }catch let err{
            print("delete Tasks data :- \(err.localizedDescription)")
        }
        return TasksData
    }
    
    func editTasksData(TasksDict: [String : Any], index:Int , searchText : String){
        
        let Tasks = (searchText == "") ? self.getAllCompletedTasksData(value:false) : self.GetFilteredData(searchText: searchText)
    // original data
        Tasks[index].title = TasksDict["title"] as? String ?? ""
        Tasks[index].desc = TasksDict["desc"] as? String ?? ""
        Tasks[index].time = TasksDict["time"] as? Date ?? Date()
        Tasks[index].completed = TasksDict["completed"] as? Bool ?? false
        Tasks[index].category = TasksDict["category"] as? String ?? ""
        
               
        do{
            try context.save()
        }catch{
            print("error in edit data")
        }
    }
    
    func GetFilteredData(searchText : String) -> [TaskDB]{
    
        var arrTasks = self.getAllCompletedTasksData(value:false)
        let myRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskDB")
        
         myRequest.predicate = NSPredicate(format: "completed = 0 AND (title CONTAINS [cd] %@ OR desc CONTAINS [cd] %@ )",searchText,searchText)

        do{
            arrTasks = try context.fetch(myRequest) as! [TaskDB]

        } catch let error{
            print(error)
        }
        
        return arrTasks
    }
    
    func GetSortedData(sortTxt : String) -> [TaskDB]{
        
        
        let arrTasks = self.getAllCompletedTasksData(value:false)
        let sortedArray = arrTasks.sorted {
            (obj1, obj2) -> Bool in
            
            return  ( sortTxt == "time") ? obj1.time! < obj2.time! : obj1.title! < obj2.title!
        }
        return sortedArray
}
    
/*========================================================================================================================================*/
    
    
    //MARK:- CategoryDB Methods
    
    func saveCategoryData(CategoryDict: [String:String]){
        let Category = NSEntityDescription.insertNewObject(forEntityName: "CategoryDB", into: context) as! CategoryDB
        Category.title = CategoryDict["categoryName"]
        
        do{
            try context.save()
        }catch let err{
            print("Categorys save error :- \(err.localizedDescription)")
        }
    }
    
    func getAllCategoryData() -> [CategoryDB]{
        var arrCategory = [CategoryDB]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CategoryDB")
        do{
            arrCategory = try context.fetch(fetchRequest) as! [CategoryDB]
        }catch let err{
            print("Error in Category fetch :- \(err.localizedDescription)")
        }
        return arrCategory
    }
    
    func deleteCategoryData(index: Int) -> [CategoryDB]{
        var CategoryData = self.getAllCategoryData() // GetData
        context.delete(CategoryData[index]) // Remove From Coredata
        CategoryData.remove(at: index) // Remove in array Category
        do{
            try context.save()
        }catch let err{
            print("delete Category data :- \(err.localizedDescription)")
        }
        return CategoryData
    }
    
    func editCategoryData(CategoryDict: [String : String], index:Int){
        let Category = self.getAllCategoryData()
    // original data
        Category[index].title = CategoryDict["categoryName"] // edit data
        do{
            try context.save()
        }catch{
            print("error in edit data")
        }
    }
    
}
