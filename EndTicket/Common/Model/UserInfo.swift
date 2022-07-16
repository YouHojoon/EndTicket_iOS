//
//  UserInfo.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/16.
//

import Foundation
struct UserInfo:Codable{
    let accountId:String
    let nickname: String?
    let token:String
    let characterImageUrl: String?
}
