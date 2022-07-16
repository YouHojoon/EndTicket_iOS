//
//  GetUserEmailResponse.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/16.
//

import Foundation
struct EmailResponse: BaseResponse{
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: Result?
    
    struct Result:Codable{
        let email: String
    }
}
