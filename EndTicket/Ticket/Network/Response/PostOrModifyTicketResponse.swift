//
//  PostTicketResponse.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/17.
//

import Foundation
import SwiftUI

struct PostOrModifyTicketResponse: BaseResponse{
    typealias Result = TicketResponse
    
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: Result
}
