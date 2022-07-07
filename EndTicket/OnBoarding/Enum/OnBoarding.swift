//
//  OnBoarding.swift
//  EndTicket
//
//  Created by 유호준 on 2022/05/27.
//

import Foundation
import SwiftUI

//MARK: - OnBoardingView 관련 정리
@frozen enum OnBoarding: CaseIterable{
    case first
    case second
    case third
    
    var title: String{
        switch self {
        case .first:
            return "목표에 다가가기"
        case .second:
            return "미래의 나는 어떨까?"
        case .third:
            return "다른 사람과 공유해요!"
        }
    }
    
    var content: String{
        switch self {
        case .first:
            return "티켓을 오른쪽으로 스와이프하면 달성\n왼쪽으로 스와이프하면 취소를 할 수 있어요!"
        case .second:
            return "나를 상상해보고 목표를 미리 설정해봐요!\n그리고 경험치를 얻어 변화를 느껴보세요:)"
        case .third:
            return "내가 달성한 목표를 공유하고\n다른 사람들의 티켓을 추가해봐요."
        }
    }
    
    var image: Image{
        switch self{
        case .first:
            return Image("onBoarding_1")
        case .second:
            return  Image("onBoarding_2")
        case .third:
            return  Image("onBoarding_3")
        }
    }
    
    @ViewBuilder
    var buttonLabel: some View{
        if self.index == OnBoarding.allCases.count - 1{
            Text("시작하기")
        }
        else{
            HStack{
                Text("다음")
                Image(systemName: "chevron.forward")
            }
        }
    }
    
    var index: Int{
        return Self.allCases.firstIndex{$0 == self}!
    }
}

