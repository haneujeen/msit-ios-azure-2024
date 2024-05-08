//
//  Model.swift
//  Twitter
//
//  Created by 한유진 on 5/8/24.
//

import Foundation

// User model
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

// Token model
struct Token: Codable {
    let success: Bool
    let token: String?
    let user: User?
    let message: String
}

// Post model
struct Post: Codable {
    let userId: String
    let content: String
}

struct PostRoot: Codable {
    let success: Bool
    let documents: [Post]
    let message: String
}
