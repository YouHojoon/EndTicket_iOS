//
//  DeleteImaingeResponse.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/11.
//

import Foundation
struct DeleteImagineResponse:BaseResponse{
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result?
    
    struct Result: Codable{
        let id: String
    }
}
