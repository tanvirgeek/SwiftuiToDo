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
    
    var body: some View {
        VStack{
            HStack{
                Text("Todo")
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .font(.largeTitle)
                Spacer(minLength: 0)
            }.padding()
            
           
            ScrollView(.vertical, showsIndicators:false){
                ForEach(results){ task in
                    LazyVStack(alignment:.leading){
                        Text("\(task.todo ?? "")")
                        Text("\(task.date ?? Date(), style:.date)")
                        Divider()
                    }
                }
            }
            
            Button(action: {
                ToDoVM.showingSheet.toggle()
            }, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
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
