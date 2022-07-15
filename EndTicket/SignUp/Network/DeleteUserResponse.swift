//
//  DeleteUserResponse.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/14.
//

import Foundation
struct DeleteUserResponse:BaseResponse{
    let code: Int
    let message: String
    let isSuccess: Bool
    let result: Result?
    struct Result: Codable{
        let id: Int
    }
}
