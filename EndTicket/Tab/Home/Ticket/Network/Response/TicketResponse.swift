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
    let category: String
    let subject: String
    let purpose: String
    let color: String
    let touchCount: Int
    let isSuccess: String?
    let currentCount: String?
    let userId: Int?
    
    func ticketResponseToTicket() -> Ticket{
        let color = Color(hex: color)
        return Ticket(category: Ticket.Category.init(rawValue: category)!, subject: subject, purpose: purpose, color: color, touchCount: touchCount, currentCount: Int(currentCount ?? "0")!, id: id)
    }
}
