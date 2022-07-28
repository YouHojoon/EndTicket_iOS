

import Foundation
struct MissionResponse: Codable{
    let id: Int
    let mission: String
    let isSuccess: String
    let remainTime: String
    
//    
    func missionResponseToMission() -> Mission{
        let dayIndex = remainTime.firstIndex(of: "일")
        let hourIndex = remainTime.firstIndex(of: "시")
        let minuteIndex = remainTime.firstIndex(of: "분")
        
        let day = dayIndex != nil ? Int(String(remainTime[remainTime.index(before: dayIndex!)]))! : 0
        let hour = hourIndex != nil ? Int(String(remainTime[remainTime.index(before: hourIndex!)]))! : 0
        let minute = minuteIndex != nil ? Int(String(remainTime[remainTime.index(before: minuteIndex!)]))! : 0
            
        let timeInterval = TimeInterval(day * 60 * 60 * 24 + hour * 60 * 60 + minute * 60)
        let due = Date(timeIntervalSinceNow:timeInterval)
        
        let isSuccess = self.isSuccess == "true"
        return Mission(id: id, mission: mission, isSuccess: isSuccess, due: due)
    }
}
