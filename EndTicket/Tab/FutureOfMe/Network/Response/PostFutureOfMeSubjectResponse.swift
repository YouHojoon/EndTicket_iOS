//
//  PostFutureOfMeSubjectResponse.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/08.
//

import Foundation
struct PostFutureOfMeSubjectResponse: BaseResponse{
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result?
    
    struct Result: Codable{
        let id: Int
        let subject: String
    }
}
