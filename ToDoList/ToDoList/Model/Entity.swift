//
//  Entity.swift
//  ToDoList
//
//  Created by Иван Бурцев on 29.11.2024.
//

import Foundation
//{"todos":[{"id":1,"todo":"Do something nice for someone you care about","completed":false,"userId":152} "total":254,"skip":0,"limit":30}
struct Todos: Decodable {
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
