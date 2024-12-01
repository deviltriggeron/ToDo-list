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
    @State private var showModal = false
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    List {
                        ForEach(items.filter{ searchText.isEmpty || searchText.contains($0.name ?? "") || searchText.contains($0.desc ?? "") }) { item in
                            NavigationLink(destination: TaskEditView(passedItem: item, initialDate: Date())
                                .environmentObject(dateHolder)) {
                                    TaskCell(passedItem: item)
                                        .environmentObject(dateHolder)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .searchable(text: $searchText)
//                    .toolbar {
//                          ToolbarItem(placement: .navigationBarTrailing) {
//                              Button("Delete all") {
//                                  clearDatabase()
//                              }
//                          }
//                      }
                }
                ZStack {
                    Text("\(items.count) задач")
                    HStack {
                        NavigationLink(destination: TaskEditView(passedItem: nil, initialDate: Date())
                            .environmentObject(dateHolder)) {
                                Image(systemName: "square.and.pencil")
                                    .environmentObject(dateHolder)
                                    .font(.system(size: 25))
                        }
                        .frame(width: 44, height: 44)
                    }
                    .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                }
            }
            .navigationTitle("Задачи")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            dateHolder.saveContext(viewContext)
        }
    }
    
    private func clearDatabase() {
            let context = viewContext
            let persistentStoreCoordinator = PersistenceController.shared.container.persistentStoreCoordinator

            for entityName in persistentStoreCoordinator.managedObjectModel.entities.map({ $0.name }).compactMap({ $0 }) {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

                do {
                    try context.execute(batchDeleteRequest)
                    print("\(entityName) cleared successfully.")
                } catch {
                    print("Failed to clear \(entityName): \(error.localizedDescription)")
                }
            }

            do {
                try context.save()
            } catch {
                print("Failed to save context after clearing database: \(error.localizedDescription)")
            }
        }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
