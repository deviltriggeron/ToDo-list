//
//  TaskCell.swift
//  ToDoList
//
//  Created by Иван Бурцев on 28.11.2024.
//

import SwiftUI

struct TaskCell: View {
    @EnvironmentObject var dateHolder: DateHolder
    @ObservedObject var passedItem: TaskItem
    var body: some View {
        CheckBoxView(passedItem: passedItem)
            .environmentObject(dateHolder)
        
        Text(passedItem.name ?? "")
            .padding(.horizontal)
    }
}
