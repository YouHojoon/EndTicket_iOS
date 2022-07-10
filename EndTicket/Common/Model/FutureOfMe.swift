//
//  FutureOfMe.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/07.
//

import Foundation
struct FutureOfMe:Codable{
    let id: String
    var subject: String?
    let title: String?
    var level: Int
    var experience: Int
    let characterImageUrl: URL?
    let characterImageName: String?
    let nickname: String
}
