//
//  TaskEditView.swift
//  ToDoList
//
//  Created by Иван Бурцев on 27.11.2024.
//

import SwiftUI

struct TaskEditView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    @State var selectedItem: TaskItem?
    @State var name: String
    @State var desc: String
    @State var dueData: Date
    @State var scheduleTime: Bool
    
    init(passedItem: TaskItem?, initialDate: Date) {
        if let taskItem = passedItem {
            _selectedItem = State(initialValue: taskItem)
            _name = State(initialValue: taskItem.name ?? "")
            _desc = State(initialValue: taskItem.desc ?? "")
            _dueData = State(initialValue: taskItem.dueDate ?? initialDate)
            _scheduleTime = State(initialValue: taskItem.scheduleTime)
        } else {
            _name = State(initialValue: "")
            _desc = State(initialValue: "")
            _dueData = State(initialValue: initialDate)
            _scheduleTime = State(initialValue: false)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Название задачи", text: $name)
                .font(.system(size: 30))
                .fontWeight(.heavy)
                .padding(.leading)
            Text(selectedItem?.dueDate?.formatted(date: .abbreviated, time: .shortened) ?? "")
                .font(.system(size: 7))
                .opacity(0.3)
                .fontWeight(.heavy)
                .padding(.leading)
            TextField("Описание", text: $desc, axis: .vertical)
                .font(.system(size: 20))
                .padding(.leading)
                
                
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
        VStack {
            if selectedItem?.IsCompleted() ?? false {
                Section(header: Text("Завершено")) {
                    Text(selectedItem?.completedDate?.formatted(date: .abbreviated, time: .shortened) ?? "")
                        .foregroundColor(.green)
                }
            } else {
                Section() {
                    Button("Сохранить", action: saveAction)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .padding()
    }
    
    private func displayComps() -> DatePickerComponents {
        return scheduleTime ? [.hourAndMinute, .date] : [.date]
    }
    
    private func saveAction() {
        withAnimation {
            if selectedItem == nil {
                selectedItem = TaskItem(context: viewContext)
            }
            selectedItem?.created = Date()
            selectedItem?.name = name
            selectedItem?.desc = desc
            selectedItem?.dueDate = dueData
            selectedItem?.scheduleTime = scheduleTime
            
            dateHolder.saveContext(viewContext)
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

