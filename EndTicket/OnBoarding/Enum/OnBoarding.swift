//
//  OnBoarding.swift
//  EndTicket
//
//  Created by 유호준 on 2022/05/27.
//

import Foundation
import SwiftUI

//MARK: - OnBoardingView 관련 정리
@frozen enum OnBoarding{
    case home
    case futureOfMe
    case recommendationGoal
    
    var title: String{
        switch self {
        case .home:
            return "티켓을 터치할 때마다 목적지에\n가까워질 수 있어요!\n티켓을 만들어보고 목표를 달성해보세요."
        case .futureOfMe:
            return "미래의 나는 어떨지 상상해보고\n목표를 미리 설정해봐요!\n그리고 캐릭터와 타이틀을 통해\n변화를 느껴보세요 :)"
        case .recommendationGoal:
            return "어떤걸 해야할 지 생각이 안난다면\n추천목표를 통해 다른 사람들의 목표를 참고해봐요!"
        }
    }
    
    @ViewBuilder
    var view: some View{
        OnBoardingView(title){
            nextView
        }
    }
    
    @ViewBuilder
    var nextView: some View{
        switch self {
        case .home:
            OnBoarding.futureOfMe.view.eraseToAnyView()
        case .futureOfMe:
            OnBoarding.recommendationGoal.view.eraseToAnyView()
        case .recommendationGoal:
            Color.clear.onAppear{
                withAnimation{
                    UserDefaults.standard.setValue(false, forKey: "isFirstStart")
                }
            }.eraseToAnyView()
        }
    }
}

