//
//  Entity.swift
//  ToDoList
//
//  Created by Иван Бурцев on 29.11.2024.
//

import Foundation

struct Todos: Decodable, Identifiable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
}

struct Task: Decodable {
    let todos: [Todos]
    let total: Int
    let skip: Int
    let limit: Int
}
