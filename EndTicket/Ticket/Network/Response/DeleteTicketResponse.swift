//
//  DeleteTicketResponse.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/21.
//

import Foundation
struct DeleteTicketResponse: BaseResponse{
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: Result
    
    struct Result: Codable{
        let ticketId: String
    }
}
