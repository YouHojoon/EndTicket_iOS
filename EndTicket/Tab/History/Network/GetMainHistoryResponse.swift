//
//  GetMainHistoryResponse.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/12.
//

import Foundation
struct GetMainHistroyResponse:BaseResponse{
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result?
    
    typealias Result = MainHistory
}
