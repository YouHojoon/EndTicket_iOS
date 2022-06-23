//
//  Ticket.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/07.
//

import Foundation
import SwiftUI

struct Ticket: Identifiable{
    let id:Int
    let title: String
    let category: Category
    let start: String
    let end: String
    let color: Color
    let touchCount: Int
    var currentCount: Int
    
    init(title:String, category: Category, start: String, end: String, color: Color,touchCount: Int, currentCount:Int = 0, id:Int = 0){
        self.title = title
        self.category = category
        self.start = start
        self.end = end
        self.color = color
        self.touchCount = touchCount
        self.currentCount = currentCount
        self.id = id
    }
    
    
    enum Category: String, CaseIterable{
        case health = "건강"
        case personality = "성격"
        case value = "가치관"
        case sport = "운동"
        case selfImprovement = "자기계발"
    }
    
    static func getDummys() -> [Ticket]{
        return [
            Ticket(title: "용기 가지기", category: .personality, start: "눈치 보지 말고 대화하기", end: "사람들 앞에서 당당한 나의 모습", color: .blue,touchCount: 15,id: 1),
            Ticket(title: "운동하기", category: .health, start: "가볍게 산책하며 숨 고르기", end: "체력도 늘고 활력도 되찾는 나의 모습", color: .white,touchCount: 15,id: 2),
            Ticket(title: "나를 믿기", category: .value, start: "나를 있는 그대로 받아들이기", end: "나를 사랑한 만큼, 상대방도 나를 사랑한다.", color: .white,touchCount: 15, id:3),
            Ticket(title: "용기 가지기", category: .personality, start: "눈치 보지 말고 대화하기", end: "사람들 앞에서 당당한 나의 모습", color: .white,touchCount: 15,id: 4),
            Ticket(title: "용기 가지기", category: .personality, start: "눈치 보지 말고 대화하기", end: "사람들 앞에서 당당한 나의 모습", color: .white,touchCount: 15,id: 5),
        ]
    }
}
