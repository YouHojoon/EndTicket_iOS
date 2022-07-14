//
//  SignUpCharacterResponse.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/14.
//

import Foundation
struct SignUpCharacterResponse: BaseResponse{
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result?
    
    struct Result: Codable{
        let characterImageUrl: String
    }
}
