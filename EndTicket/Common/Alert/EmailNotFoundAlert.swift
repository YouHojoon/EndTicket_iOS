//
//  EmailNotFoundAlert.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/16.
//

import Foundation
import SwiftUI
struct EmailNotFoundAlert: View{
    @Binding private var isPresented: Bool
    init(isPresented:Binding<Bool>){
        _isPresented = isPresented
    }
    var body: some EndTicketAlert{
        EndTicketAlertImpl{
            Text("이메일을 찾을 수 없습니다. 이메일 권한을 허용을 해주세요.\n애플 로그인이시라면 애플 로그인 사용을 해제 후 다시 로그인해주세요.")
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
