//
//  TouchTicketResponse.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/23.
//

import Foundation
struct TouchTicketResponse: BaseResponse{
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result?
    
    struct Result:Codable{
        let ticketId: String
        let touchCount: Int
        let touchCountId: Int
    }
}
