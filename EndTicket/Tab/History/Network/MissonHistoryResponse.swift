//
//  MissonHIstoryResponse.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/28.
//

import Foundation
struct MissionHistoryResponse: Codable{
    let id: Int
    let mission : String
    let completeDate: String
    let isSuccess: String
    let completeTime: String
}

