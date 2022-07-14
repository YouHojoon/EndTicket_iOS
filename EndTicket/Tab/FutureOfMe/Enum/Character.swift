//
//  Character.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/14.
//

import Foundation
import SwiftUI
enum Character: String,CaseIterable{
    case flower = "꽃"
    case cat = "냥냥"
    case star = "별"
    
    
    var id: Int{
        switch self {
        case .flower:
            return 1
        case .cat:
            return 6
        case .star:
            return 11
        }
    }
    
    var image: Image{
        switch self{
        case .flower:
            return Image("flower")
        case .cat:
            return Image("cat")
        case .star:
            return Image("star")
        }
    }
    
    var info: String{
        switch self {
        case .flower:
            return "소심하고 눈치도 많이봐요. 현재 성격을 바꾸고싶어서 노력중인 친구에요. 자존감의 꽃을 피우고싶어해요."
        case .cat:
            return "자기계발을 항상 계획하고있지만 작심삼일로 포기하게 되는 친구에요. 어떻게 하면 오래할수있을까 생각하고 있어요. 자기계발과 함께 건강에 대해서도 관심을 가지고 있어요."
        case .star:
            return "긍정에너지를 가지고 있는 별 같은 친구라 많은 사람들과 잘 지내요. 하지만 요즘에는 관계에 대한 고민이 많아지고 있어요."
        }
    }
}
