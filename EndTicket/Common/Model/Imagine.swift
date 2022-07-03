//
//  Imagin.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/09.
//

import Foundation

struct Imagine{
    let goal: String
    let desciption: String
    var isCompleted: Bool = false
    
    static func getDummys() -> [Imagine]{
        return [
            Imagine(goal: "용기 가지기", desciption: "사람들 앞에서 당당한 나의 모습"),
            Imagine(goal: "운동하기", desciption: "체력도 늘고 활력도 되찾는 나의 모습"),
            Imagine(goal: "나를 믿기", desciption: "나를 사랑한만큼, 상대방도 나를 사랑한다"),
            Imagine(goal: "공부하기", desciption: "높은 학점도 받고, 할 수 있다는 생각이 든다"),
            Imagine(goal: "용기 가지기", desciption: "사람들 앞에서 당당한 나의 모습")
        ]
    }
}
