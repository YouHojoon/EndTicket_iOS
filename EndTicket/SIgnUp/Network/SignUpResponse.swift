//
//  SignUpResponse.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/14.
//

import Foundation
struct SignUpResponse: BaseResponse{
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result
    
    struct Result: Codable{
        let nickname: String
    }
}



