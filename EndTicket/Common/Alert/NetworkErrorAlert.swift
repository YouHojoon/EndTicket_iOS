//
//  NetworkErrorAlert.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/14.
//

import Foundation
import SwiftUI
struct NetworkErrorAlert:View{
    @Binding private var isPresented: Bool
    init(isPresented:Binding<Bool>){
        _isPresented = isPresented
    }
    var body: some EndTicketAlert{
        EndTicketAlertImpl{
            Text("로그인 과정 중 오류가 발생했습니다.")
                .font(.system(size:16,weight: .bold))
        }primaryButton: {
            EndTicketAlertButton(label:Text("확인")){
                withAnimation {
                    isPresented = false
                }
            }
        }
    }
}

