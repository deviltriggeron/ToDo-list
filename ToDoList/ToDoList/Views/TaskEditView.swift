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
        Form {
            Section(header: Text("Task")) {
                TextField("Task name", text: $name)
                TextField("Desc", text: $desc)
            }
            
            Section(header: Text("Due Date")) {
                Toggle("Schedule time", isOn: $scheduleTime)
                DatePicker("Due Date", selection: $dueData, displayedComponents: displayComps())
            }
            
            if selectedItem?.IsCompleted() ?? false {
                Section(header: Text("Completed")) {
                    Text(selectedItem?.completedDate?.formatted(date: .abbreviated, time: .shortened) ?? "")
                        .foregroundColor(.green)
                }
            }
            
            Section() {
                Button("Save", action: saveAction)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
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

