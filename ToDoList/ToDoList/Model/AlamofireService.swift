//
//  AlamofireService.swift
//  ToDoList
//
//  Created by Иван Бурцев on 29.11.2024.
//

import Foundation
import Alamofire

import Alamofire

class AlamofireService: ObservableObject {
    func fetchData(completion: @escaping () -> Void) {
        AF.request("https://dummyjson.com/todos", method: .get).responseDecodable(of: Task.self) { response in
            switch response.result {
            case .success(let data):
                let backgroundContext = PersistenceController.shared.container.newBackgroundContext()
                backgroundContext.perform {
                    data.todos.forEach { todo in
                        let newTaskItem = TaskItem(context: backgroundContext)
                        newTaskItem.name = String(todo.id)
                        newTaskItem.desc = todo.todo
                        newTaskItem.isCompleted = todo.completed
                        newTaskItem.dueDate = Date()
                        if todo.completed {
                            newTaskItem.completedDate = Date()
                        }
                    }

                    do {
//                        sleep(30)
                        try backgroundContext.save()
                        DispatchQueue.main.async {
                            completion()
                        }
                    } catch {
                        print("Error save to Core Data: \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                print("Error decodable Alamofire: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
}


