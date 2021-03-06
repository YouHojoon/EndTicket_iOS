//
//  HistoryType.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/12.
//

import Foundation
import SwiftUI

enum HistoryType: String,CaseIterable{
    case ticket = "티켓"
//    case mission = "주간미션"
    case imagine = "상상하기"
    
    @ViewBuilder
    //티켓을 위한 selected가 있어서 좋은 구조인지 모르겠음
    func headContent(dismiss: DismissAction, isNotScrolled: Binding<Bool>,selected:Binding<Ticket.Category>? = nil) -> some View{
        switch self {
        case .ticket:
            VStack(alignment: .leading, spacing:0){
               baseHeader(dismiss: dismiss, isNotScrolled: isNotScrolled)
                TicketCategorySelectView(selected: selected!,shouldShowTitle:false,isEssential:false, shouldRemoveAllCategory:false)
                .padding(.bottom,15)
            }
            .background(Color.white.edgesIgnoringSafeArea(.horizontal))
        default:
            VStack(alignment: .leading, spacing:0){
               baseHeader(dismiss: dismiss,isNotScrolled: isNotScrolled)
            }
            .background(Color.white.edgesIgnoringSafeArea(.horizontal))
        }
    }
    
    var pepTalk: String{
        switch self {
        case .ticket:
            return "잘하셨어요!\n앞으로 더 기대 되는걸요:)"
//        case .mission:
//            return "꾸준히 하고 계신가요?\n달성하다보면 좋아질 거에요!"
        case .imagine:
            return "상상한 것보다\n더 잘 됐을 거에요:)"
        }
    }
    
    func mainContent<Items>(isNotScrolled:Binding<Bool>,@ViewBuilder items: () -> Items) -> some View where Items:View{
        ZStack{
            Color.gray10.ignoresSafeArea()
            EndTicketScrollView(isNotScrolled:isNotScrolled){
                LazyVStack(spacing:20){
                    items()
                    Spacer()
                }.padding(.top, 30)
                .padding(.horizontal, 20)
            }
        }
    }
    
    
    private func baseHeader(dismiss:DismissAction, isNotScrolled: Binding<Bool>) -> some View{
        Group{
            HStack{
                Image("arrow_left")
                    .font(.system(size:15, weight: .medium))
                    .frame(width: 40, height: 40)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        dismiss()
                    }
                    .padding(.leading,10)
                Spacer()
                Text("\(rawValue)")
                    .font(.system(size: 21,weight: .bold))
                    .offset(x:-20)
                Spacer()
            }.padding(.top, 23.67)
            .padding(.bottom, 13)
            
            if isNotScrolled.wrappedValue{
                Text("\(pepTalk)")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 22,weight: .bold))
                    .padding(.bottom,20)
                    .padding(.top,30)
                    .padding(.leading,20)
            }
            
        }
    }
}
