//
//  Book.swift
//  KakaoAPITestWithAlamofire
//
//  Created by 한유진 on 4/3/24.
//

import Foundation

struct Document: Codable {
    let title: String
    let authors: [String]
    let price: Int
    let thumbnail: String
    let url: String
}

struct Meta: Codable {
    let isEnd: Bool
    
    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
    }
}

struct Root: Codable {
    let meta: Meta
    let documents: [Document]
}
