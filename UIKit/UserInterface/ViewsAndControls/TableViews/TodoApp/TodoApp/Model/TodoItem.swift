//
//  TodoItem.swift
//  TodoApp
//
//  Created by 한유진 on 3/17/24.
//

import Foundation

struct TodoItem: Codable {
    var id: Int
    var title: String
    var isCompleted: Bool
}
