//
//  DateHolder.swift
//  ToDoList
//
//  Created by Иван Бурцев on 27.11.2024.
//

import SwiftUI
import CoreData

class DateHolder: ObservableObject {
     
    init(_ context: NSManagedObjectContext) {
        
    }
    
    func saveContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
