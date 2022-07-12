//
//  MainHistory.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/13.
//

import Foundation
struct MainHistory: Codable{
    private let dreamCount: Int
    private let ticketCount: Int
    private let missionCount: Int
    let ticketTouchCount: Int
    
    func getHistoryCount(type:HistoryType) -> Int{
        switch type {
        case .ticket:
            return ticketCount
        case .mission:
            return missionCount
        case .imagine:
            return dreamCount
        }
    }
}
