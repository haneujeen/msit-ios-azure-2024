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
    let thumbnail: String?
    let url: String
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.authors = try container.decode([String].self, forKey: .authors)
        self.price = try container.decode(Int.self, forKey: .price)
        self.thumbnail = try container.decodeIfPresent(String.self, forKey: .thumbnail)
        self.url = try container.decode(String.self, forKey: .url)
    }
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
