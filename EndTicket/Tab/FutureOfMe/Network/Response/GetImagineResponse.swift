//
//  GetImagineResponse.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/09.
//

import Foundation
struct GetImagineResponse: BaseResponse{
    let code: Int
    let message: String
    let isSuccess: Bool
    let result: Result?
    
    struct Result: Codable{
        let dream: [ImagineResponse]
    }
}
