//
//  SignInResponse.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/23.
//

import Foundation

struct SignInResponse:BaseResponse{
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result?
    
    typealias Result = UserInfo
}

