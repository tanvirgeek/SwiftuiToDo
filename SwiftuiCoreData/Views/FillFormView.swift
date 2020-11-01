//
//  FillFormView.swift
//  SwiftuiCoreData
//
//  Created by MD Tanvir Alam on 31/10/20.
//

import SwiftUI

struct FillFormView: View {
    @StateObject var ToDoVM:ToDoViewModel
    @Environment (\.managedObjectContext) var context
    var body: some View {
        VStack{
            Text("New Task")
                .fontWeight(.heavy)
                .font(.largeTitle)
            TextEditor(text: $ToDoVM.todo)
            Text("When")
                .fontWeight(.heavy)
                .font(.largeTitle)
            
            Button(action: {
                ToDoVM.updateDate(title: "Today")
            }, label: {
                Text("Today")
                    .fontWeight(.heavy)
                    .padding()
            }).background(ToDoVM.checkDate() == "Today" ? Color.blue : Color.gray)
            .foregroundColor(.white)
            
            Button(action: {
                ToDoVM.updateDate(title: "Tomorrow")
            }, label: {
                Text("Tomorrow")
                    .fontWeight(.heavy)
                    .padding()
            }).background(ToDoVM.checkDate() == "Tomorrow" ? Color.blue : Color.gray)
            .foregroundColor(.white)
            
            
            DatePicker("", selection: $ToDoVM.date)
                .labelsHidden()
            
            Button(action: {
                ToDoVM.writeToCoreData(context: context)
            }, label: {
                Text("Add New Task")
                    .padding()
                    .cornerRadius(10)
            }).alert(isPresented: $ToDoVM.savingErrorAlert){
                Alert(title: Text("Error"), message: Text("Todo was not saved"), dismissButton: .default(Text("Got it")))
            }.disabled( ToDoVM.todo == "" ? true : false)
            .opacity( ToDoVM.todo == "" ? 0.5 : 1)
            .background( ToDoVM.todo == "" ? Color.black : Color.black)
            .cornerRadius(10)
        }
        
    }
}

struct FillFormView_Previews: PreviewProvider {
    static var previews: some View {
        FillFormView(ToDoVM: ToDoViewModel())
    }
}
