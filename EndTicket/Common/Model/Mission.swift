//
//  Mission'.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/13.
//

import Foundation
struct Mission:Codable{
    let id: Int
    let mission: String
    let isSuccess: Bool
    let due: Date
    
    func remainTimeString() -> String{
        var remainTime = due.timeIntervalSinceNow
        let day = Int(remainTime / (60*60*24))
        remainTime -= Double(day * (60*60*24))
        let hour = Int(remainTime / (60*60))
        remainTime -= Double(hour * (60*60))
        let minute = Int(remainTime / 60)
        
        if day != 0{
            return "\(day)일 \(hour)시간 \(minute)분"
        }
        else{
            return "약 \(hour)시간 \(minute)분"
        }
        
    }
}
