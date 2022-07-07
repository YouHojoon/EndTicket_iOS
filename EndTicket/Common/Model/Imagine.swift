//
//  Imagin.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/09.
//

import Foundation
import SwiftUI

struct Imagine{
    let subject: String
    let purpose: String
    let color: Color
    var isSuccessed: Bool = false
    
    static func getDummys() -> [Imagine]{
        return [
            Imagine(subject:"용기 가지기" , purpose: "사람들 앞에서 당당한 나의 모습", color: .ticketRed1),
            Imagine(subject:"용기 가지기" , purpose: "사람들 앞에서 당당한 나의 모습", color: .ticketRed1),
            Imagine(subject:"용기 가지기" , purpose: "사람들 앞에서 당당한 나의 모습", color: .ticketRed1),
            Imagine(subject:"용기 가지기" , purpose: "사람들 앞에서 당당한 나의 모습", color: .ticketRed1)
        ]
    }
}
