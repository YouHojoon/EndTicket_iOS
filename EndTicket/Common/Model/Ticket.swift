//
//  Ticket.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/07.
//

import Foundation
import SwiftUI

struct Ticket: Identifiable, Equatable{
    let id:Int
    let category: Category
    let subject: String
    let purpose: String
    let color: Color
    let touchCount: Int
    var currentCount: Int
    
    init(category: Category, subject:String,purpose:String, color: Color,touchCount: Int, currentCount:Int = 0, id:Int = 0){
        self.category = category
        self.subject = subject
        self.purpose = purpose
        self.color = color
        self.touchCount = touchCount
        self.currentCount = currentCount
        self.id = id
    }
    
    
    enum Category: String, CaseIterable{
        case all = "전체"
        case health = "건강"
        case personality = "성격"
        case value = "가치관"
        case selfImprovement = "자기계발"
        case relationship = "대인관계"
    }
    
    static func getDummys() -> [Ticket]{
        return [
            Ticket( category: .personality, subject: "눈치 보지 말고 대화하기", purpose: "사람들 앞에서 당당한 나의 모습", color: .ticketRed1,touchCount: 15,id: 1),
            Ticket(category: .health, subject: "가볍게 산책하며 숨 고르기", purpose: "체력도 늘고 활력도 되찾는 나의 모습", color: .ticketBlue1,touchCount: 15,id: 2),
            Ticket( category: .value, subject: "나를 있는 그대로 받아들이기", purpose: "나를 사랑한 만큼, 상대방도 나를 사랑한다.", color: .ticketGray1,touchCount: 15, id:3),
            Ticket(category: .personality, subject: "눈치 보지 말고 대화하기", purpose: "사람들 앞에서 당당한 나의 모습", color: .ticketOrange1,touchCount: 15,id: 4),
            Ticket(category: .personality, subject: "눈치 보지 말고 대화하기", purpose: "사람들 앞에서 당당한 나의 모습", color: .ticketPurple1,touchCount: 15,id: 5),
        ]
    }
}
