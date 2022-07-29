

import Foundation
struct MissionResponse: Codable{
    let id: Int
    let mission: String
    let isSuccess: String
    let remainTime: String
    
//    
    func missionResponseToMission() -> Mission{
        let dayIndex = remainTime.firstIndex(of: "일")!
        let hourIndex = remainTime.firstIndex(of: "시")!
        let minuteIndex = remainTime.firstIndex(of: "분")!
        
        let day = Int(String(remainTime[remainTime.index(before: dayIndex)]))!
        let hour = Int(String(remainTime[remainTime.index(after: dayIndex) ..< hourIndex]))!
        let minute = Int(String(remainTime[remainTime.index(after: hourIndex) ..< minuteIndex]))!
            
        let timeInterval = TimeInterval(day * 60 * 60 * 24 + hour * 60 * 60 + minute * 60)
        let due = Date(timeIntervalSinceNow:timeInterval)
        
        let isSuccess = self.isSuccess == "true"
        return Mission(id: id, mission: mission, isSuccess: isSuccess, due: due)
    }
}
