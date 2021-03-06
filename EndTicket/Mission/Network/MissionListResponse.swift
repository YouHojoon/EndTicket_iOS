//
//  GetMissionResponse.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/13.
//

import Foundation
struct MissionListResponse: BaseResponse{
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result?
        
    struct Result:Codable{
        let mission: [Mission]
    }
}
