//
//  AlamofireService.swift
//  ToDoList
//
//  Created by Иван Бурцев on 29.11.2024.
//

import Foundation
import Alamofire

class AlamofireService: ObservableObject {
    static let shared = AlamofireService()
    init(){}
    func fetchData(completion: @escaping (Task?) -> Void) {
        AF.request("https://dummyjson.com/todos", method: .get).responseDecodable(of: Task.self) { response in
            switch response.result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print("Decodable error:\(error)")
            }
        }
    }
}

