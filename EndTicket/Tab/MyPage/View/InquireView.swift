//
//  InquireView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/14.
//

import SwiftUI

struct InquireView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var text = ""
    @FocusState private var focus
    @State private var isKeyboardShow = false
    @State private var isEnabledButton = false
    @State private var shouldShowDeleteUserAlert = false
    @EnvironmentObject private var viewModel: MyPageViewModel
    @EnvironmentObject private var siginInViewModel : SignInViewModel
    private let type: `Type`
    enum `Type`{
        case inquire
        case deleteUser
        
        var title: String{
            switch self{
            case .inquire:
                return "문의하기"
            case .deleteUser:
                return "회원탈퇴"
            }
        }
        
        var placeholder: String{
            switch self{
            case .inquire:
                return "하고싶은 말이 있으신가요?"
            case .deleteUser:
                return "어떤점 때문에 탈퇴하시는지 알려주세요!"
            }
        }
        
        var buttonColor: Color{
            switch self{
            case .inquire:
                return .mainColor
            case .deleteUser:
                return .black
            }
        }
    }
    
    init(type:`Type`){
        self.type = type
    }
    
    var body: some View {
        VStack(spacing:0){
            Group{
                HStack{
                    Image("arrow_left")
                        .font(.system(size:15, weight: .medium))
                        .frame(width:40,height: 40)
                        .padding(.leading, 10)
                        .onTapGesture {
                            dismiss()
                        }
                    Spacer()
                    Text("\(type.title)")
                        .font(.system(size: 21,weight: .bold))
                    Spacer()
                }
                .padding(.vertical, 13)
            }
            
            Group{
                TextEditor(text: $text)
                    .focused($focus)
                    .font(.system(size: 18))
                    .overlay(
                        text.isEmpty ?
                        Text("\(type.placeholder)")
                            .font(.system(size:18,weight:.medium))
                            .foregroundColor(.gray300)
                            .padding([.leading,.top],9)
                            .onTapGesture{
                                focus = true
                            } : nil
                        ,alignment: .topLeading)
                    .onChange(of: text){
                        if !$0.isEmpty{
                            isEnabledButton = true
                            if $0.count > 300{
                                text = String($0.prefix(300))
                            }
                        }
                        else{
                            isEnabledButton = false
                        }
                    }
                
                Button{
                    switch type {
                    case .inquire:
                        viewModel.inquire(text)
                    case .deleteUser:
                        shouldShowDeleteUserAlert = true
                    }
                }label: {
                    Text("\(type.title)")
                        .font(.system(size: 15,weight: .bold))
                        .frame(maxWidth:.infinity, maxHeight: 50)
                        .foregroundColor(.white)
                }.background(isEnabledButton ? type.buttonColor : .gray200)
                .disabled(!isEnabledButton)
                .cornerRadius(10)
                .padding(.bottom, isKeyboardShow ? 15 : 0)
            }.padding(.horizontal,20)
        }
        .listenKeyBoardShowAndHide($isKeyboardShow)
        .onReceive(viewModel.isSuccessInquire){
            if $0{
                dismiss()
            }
        
        }
        .onReceive(viewModel.isSuccessDeleteUser){
            if $0{
                siginInViewModel.disconnect()
            }
        }
        
        .alert(isPresented: $shouldShowDeleteUserAlert){
            EndTicketAlertImpl{
                Text("정말로 탈퇴하시겠습니까?")
                    .font(.system(size:18,weight:.bold))
            }primaryButton: {
                EndTicketAlertButton(label:Text("취소").foregroundColor(.gray400)){
                    shouldShowDeleteUserAlert = false
                }
            }secondaryButton: {
                EndTicketAlertButton(label:Text("삭제").foregroundColor(.red)){
                    shouldShowDeleteUserAlert = false
                    viewModel.deleteUser(text: text)
                }
            }
        }
    }
}

struct InquireView_Previews: PreviewProvider {
    static var previews: some View {
        InquireView(type:.inquire)
    }
}
