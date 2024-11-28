//
//  CheckBoxView.swift
//  ToDoList
//
//  Created by Иван Бурцев on 28.11.2024.
//

import SwiftUI

struct CheckBoxView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    @ObservedObject var passedItem: TaskItem
    var body: some View {
        Image(systemName: passedItem.IsCompleted() ? "checkmark.circle.fill" : "circle")
            .foregroundColor(passedItem.IsCompleted() ? .green : .secondary)
            .onTapGesture {
                if !passedItem.IsCompleted() {
                    passedItem.completedDate = Date()
                } else {
                    passedItem.completedDate = nil
                }
                dateHolder.saveContext(viewContext)
            }
    }
}

//#Preview {
//    CheckBoxView()
//}
