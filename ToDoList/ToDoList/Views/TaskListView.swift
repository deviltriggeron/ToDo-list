//
//  ContentView.swift
//  ToDoList
//
//  Created by Иван Бурцев on 27.11.2024.
//

import SwiftUI
import CoreData

struct TaskListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TaskItem.dueDate, ascending: true)],
        animation: .default)
    private var items: FetchedResults<TaskItem>

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    List {
                        ForEach(items) { item in
                            NavigationLink(destination: TaskEditView(passedItem: item, initialDate: Date())
                                .environmentObject(dateHolder)) {
                                    TaskCell(passedItem: item)
                                        .environmentObject(dateHolder)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                    }
                }
                ZStack {
                    Text("\(items.count) tasks")
                    HStack {
                        NavigationLink(destination: TaskEditView(passedItem: nil, initialDate: Date())
                            .environmentObject(dateHolder)) {
                                Image(systemName: "square.and.pencil")
                                    .environmentObject(dateHolder)
                                    
                        }
                            .padding()
                    }
                    .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                }
                .frame(maxWidth: .infinity, alignment: .bottomTrailing)
            }.navigationTitle("Tasks")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            dateHolder.saveContext(viewContext)
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

//#Preview {
//    TaskListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}
