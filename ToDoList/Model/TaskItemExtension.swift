//
//  TaskItemExtension.swift
//  ToDoList
//
//  Created by Иван Бурцев on 28.11.2024.
//

import SwiftUI

extension TaskItem {
    
    func IsCompleted() -> Bool {
        return completedDate != nil
    }
}
