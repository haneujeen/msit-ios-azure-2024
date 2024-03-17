//
//  SectionTitle.swift
//  TodoApp
//
//  Created by 한유진 on 3/17/24.
//

import Foundation

enum SectionTitle: String, CaseIterable {
    case today = "Today"
    case oneDayAgo = "A Day Ago"
    case previousSevenDays = "Previous 7 Days"
    case previousThirtyDays = "Previous 30 Days"
    case older = "Older"
    
//    static func section(for item: TodoItem) -> SectionTitle {
//        let calendar = Calendar.current
//        let now = Date()
//        let creationDate = item.creationDate
//        let daysAgo = calendar.dateComponents([.day], from: creationDate, to: now).day!
//        
//        switch daysAgo {
//        case 0:
//            return .today
//        case 1:
//            return .oneDayAgo
//        case 2...7:
//            return .previousSevenDays
//        case 8...30:
//            return .previousThirtyDays
//        default:
//            return .older
//        }
//    }
}
