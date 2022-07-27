//
//  Mission'.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/13.
//

import Foundation
struct Mission: Codable{
    let id: Int
    let mission: String
    let isSuccess: String
    let remainTime: String?
}
