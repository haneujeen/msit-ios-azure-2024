//
//  Model.swift
//  Twitter
//
//  Created by 한유진 on 5/8/24.
//

import Foundation

struct User: Codable {
    let userId: String
    let userName: String
    let fileName: String
}

struct UserRoot: Codable {
    let success: Bool
    let documents: User
    let message: String
}

struct Token: Codable {
    let success: Bool
    let token: String?
    let message: String
}
