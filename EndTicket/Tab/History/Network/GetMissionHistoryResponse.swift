//
//  GetMissionHistoryResponse.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/13.
//

import Foundation
struct GetMissionHistoryResponse: BaseResponse{
    let code: Int
    let message: String
    let isSuccess: Bool
    let result: Result?
    
    struct Result: Codable{
        let mission: [Mission]
    }
}
