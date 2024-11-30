//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Иван Бурцев on 27.11.2024.
//

import SwiftUI

@main
struct ToDoListApp: App {
    let persistenceController = PersistenceController.shared
    let services = AlamofireService()
    var body: some Scene {
        WindowGroup {
            
            let context = persistenceController.container.viewContext
            let dateHolder = DateHolder(context)
            TaskListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(dateHolder)
                .onAppear {
                    if isFirstLaunch() {
                        services.fetchData {
                            print("Data loaded")
                        }
                    }
                }
        }
    }
    private func resetAndFetchData() {
        UserDefaults.standard.set(false, forKey: "HasLaunchedBefore")
        services.fetchData {
            print("Data refresh")
        }
    }
}

private func isFirstLaunch() -> Bool {
    let isFirstLaunch = !UserDefaults.standard.bool(forKey: "HasLaunchedBefore")
    if isFirstLaunch {
        UserDefaults.standard.set(true, forKey: "HasLaunchedBefore")
    }
    return isFirstLaunch
}


