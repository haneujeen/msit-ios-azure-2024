//
//  Model.swift
//  SchoolApp
//
//  Created by 한유진 on 5/1/24.
//

import Foundation

struct Student: Codable {
    let id: Int
    let name: String
    let major: String?
    let grade: Int
    let gender: String
}

struct StudentRoot: Codable {
    let success: Bool
    let documents: [Student]
    let message: String
}

struct Book: Codable {
    let id: Int
    let title: String
    let author: String
}

struct BookRoot: Codable {
    let success: Bool
    let documents: [Book]
    let message: String
}
