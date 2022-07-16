//
//  FutureOfMe.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/07.
//

import Foundation
struct FutureOfMe:Codable{
    let id: Int
    var subject: String?
    let title: String?
    var level: Int
    var experience: Int
    let characterImageUrl: URL?
    let characterImageId: Int?
    let nickname: String
    
    mutating func incresedExperience(_ amount: Int){
        if level == 40 && experience == 100{
            return
        }
        else{
            experience += amount
            if experience == 100 {
                if level != 40{
                    level += 1
                    experience = 0
                }
            }
        }
    }
}
