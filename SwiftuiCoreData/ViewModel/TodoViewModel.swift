//
//  TodoViewModel.swift
//  SwiftuiCoreData
//
//  Created by MD Tanvir Alam on 31/10/20.
//

import Foundation
import CoreData

class ToDoViewModel:ObservableObject{
    @Published var todo = ""
    @Published var date = Date()
    @Published var showingSheet = false
    @Published var savingErrorAlert = false
    @Published var updateItem:Todo!
    let calender = Calendar.current
    
    func checkDate() -> String{
        if (calender.isDateInToday(date)){
            return "Today"
        }else if(calender.isDateInTomorrow(date)){
            return "Tomorrow"
        }else{
            return "SomeotherDate"
        }
    }
    
    func updateDate(title:String){
        if(title == "Today"){
            date = Date()
        }else if(title == "Tomorrow"){
            date = calender.date(byAdding: .day, value: 1, to: Date())!
        }else{
            //
        }
    }
    
    func writeToCoreData(context: NSManagedObjectContext){
        //update item
        if updateItem != nil {
            updateItem.date = date
            updateItem.todo = todo
            
            try! context.save()
            
            updateItem = nil
            showingSheet.toggle()
        }else{
            let newTodo = Todo(context: context)
            newTodo.date = date
            newTodo.todo = todo
            
            do {
                try context.save()
                showingSheet.toggle()
                //print(showingSheet)
                
            }catch{
                print("Error Saving data")
                savingErrorAlert.toggle()
            }
        }
        
    }
    func editToDo(todo:Todo){
        updateItem = todo
        self.date = updateItem.date!
        self.todo = updateItem.todo!
      showingSheet.toggle()
    }
}
