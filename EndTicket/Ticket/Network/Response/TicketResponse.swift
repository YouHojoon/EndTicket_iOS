//
//  TicketReponse.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/16.
//

import Foundation
import SwiftUI
struct TicketResponse:Codable{
    let id: Int
    let title: String
    let category: String
    let start: String
    let end: String
    let color: String
    let touchCount: Int
    let isSuccess: String?
    let currentCount: String?
    let userId: Int?
    
    func ticketResponseToTicket() -> Ticket{
        let color = Color(hex: color)
        return Ticket(title: title, category: Ticket.Category.init(rawValue: category)!, start: start, end: end, color: color, touchCount: touchCount, currentCount: Int(currentCount ?? "0")!, id: id)
    }
}
