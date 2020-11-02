//
//  ContentView.swift
//  SwiftuiCoreData
//
//  Created by MD Tanvir Alam on 31/10/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var ToDoVM = ToDoViewModel()
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)], animation:.spring()) var results : FetchedResults<Todo>
    @Environment (\.managedObjectContext) var context
    
    var body: some View {
        VStack{
            HStack{
                Text("Todo")
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .font(.largeTitle)
                Spacer(minLength: 0)
            }.padding()
            
            Spacer()
            
            if results.isEmpty{
                Text("No Todo")
            }else{
                ScrollView(.vertical, showsIndicators:false){
                    LazyVStack{
                        ForEach(results){ task in
                            VStack(alignment:.leading){
                                Text("\(task.todo ?? "")")
                                Text("\(task.date ?? Date(), style:.date)")
                                Divider()
                            }.contextMenu(/*@START_MENU_TOKEN@*/ContextMenu(menuItems: {
                                Button(action: {
                                    
                                    ToDoVM.editToDo(todo: task)
                                }, label: {
                                    Text("Edit")
                                })
                                Button(action: {
                                    context.delete(task)
                                    try! context.save()
                                }, label: {
                                    Text("Delete")
                                })
                                Text("Menu Item 3")
                            })/*@END_MENU_TOKEN@*/)
                        }
                    }
                }
            }
            
            Spacer()
            
            Button(action: {
                ToDoVM.showingSheet.toggle()
            }, label: {
                Text("Add New Todo")
                    .fontWeight(.heavy)
                    .font(.largeTitle)
            }).sheet(isPresented: $ToDoVM.showingSheet, content: {
                FillFormView(ToDoVM: ToDoVM)
            })
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
