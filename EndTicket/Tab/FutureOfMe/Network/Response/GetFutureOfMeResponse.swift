//
//  GetFutureOfMeResponse.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/07.
//

import Foundation
struct GetFutureOfMeResponse: BaseResponse{
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result?
    
    typealias Result = FutureOfMe
}
