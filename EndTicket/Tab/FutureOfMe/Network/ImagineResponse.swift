//
//  ImagineResponse.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/09.
//

import Foundation
import SwiftUI
struct ImagineResponse: Codable{
    let id: Int
    let subject: String
    let purpose: String
    let color: String
    let isSuccess: Int?
    
    func imagineResponseToImagine() -> Imagine{
        let color = Color.init(hex: color)
        return Imagine(subject: subject, purpose: purpose, color: color,isSuccess: isSuccess == 1 ? true : false, id: id)
    }
}
