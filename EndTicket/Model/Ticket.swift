//
//  Ticket.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/07.
//

import Foundation
struct Ticket{
    let title: String
    let type: `Type`
    let startStation: String
    let endStation: String
    
    enum `Type`: CustomStringConvertible{
        case health
        case personality
        case value
        
        var description: String{
            switch self{
            case .health:
                return "건강"
            case .personality:
                return "성격"
            case .value:
                return "가치관"
            }
        }
    }
    
    static func getDummys() -> [Ticket]{
        return [
            Ticket(title: "용기 가지기", type: .personality, startStation: "눈치 보지 말고 대화하기", endStation: "사람들 앞에서 당당한 나의 모습"),
            Ticket(title: "운동하기", type: .health, startStation: "가볍게 산책하며 숨 고르기", endStation: "체력도 늘고 활력도 되찾는 나의 모습"),
            Ticket(title: "나를 믿기", type: .value, startStation: "나를 있는 그대로 받아들이기", endStation: "나를 사랑한 만큼, 상대방도 나를 사랑한다."),
            Ticket(title: "용기 가지기", type: .personality, startStation: "눈치 보지 말고 대화하기", endStation: "사람들 앞에서 당당한 나의 모습"),
            Ticket(title: "용기 가지기", type: .personality, startStation: "눈치 보지 말고 대화하기", endStation: "사람들 앞에서 당당한 나의 모습"),
        ]
    }
}
