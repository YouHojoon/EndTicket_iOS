//
//  GetTicketResponse.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/16.
//

import Foundation
import SwiftUI

struct TicketListResponse: BaseResponse{
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: Result?
    
    struct Result: Codable{
        let ticket: [TicketResponse]
    }
}
