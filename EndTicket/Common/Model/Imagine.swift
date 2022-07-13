//
//  Imagin.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/09.
//

import Foundation
import SwiftUI

struct Imagine: Identifiable{
    let id: Int
    let subject: String
    let purpose: String
    let color: Color
    var isSuccess: Bool
    let updatedAt: String?
    
    init(subject:String, purpose:String, color: Color, isSuccess: Bool = false, id:Int = 0, updatedAt:String? = nil){
        self.subject = subject
        self.purpose = purpose
        self.color = color
        self.isSuccess = isSuccess
        self.id = id
        self.updatedAt = updatedAt
    }
    
    static func getDummys() -> [Imagine]{
        return [
            Imagine(subject:"용기 가지기" , purpose: "사람들 앞에서 당당한 나의 모습", color: .ticketRed1,updatedAt: "2022.07.12"),
            Imagine(subject:"용기 가지기" , purpose: "사람들 앞에서 당당한 나의 모습", color: .ticketRed1),
            Imagine(subject:"용기 가지기" , purpose: "사람들 앞에서 당당한 나의 모습", color: .ticketRed1),
            Imagine(subject:"용기 가지기" , purpose: "사람들 앞에서 당당한 나의 모습", color: .ticketRed1)
        ]
    }
}
