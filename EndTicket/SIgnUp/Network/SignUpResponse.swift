//
//  SignUpResponse.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/14.
//

import Foundation
struct SignUpResponse: Codable{
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: SignUpResponseResult
    
    struct SignUpResponseResult: Codable{
        let nickname: String
    }
}



