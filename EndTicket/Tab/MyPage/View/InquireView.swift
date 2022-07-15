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
    @EnvironmentObject private var viewModel: MyPageViewModel
    
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
                    Image(systemName: "arrow.backward")
                        .font(.system(size:15, weight: .medium))
                        .padding(.trailing,13)
                        .onTapGesture {
                            dismiss()
                        }
                    Spacer()
                    Text("\(type.title)")
                        .font(.system(size: 21,weight: .bold))
                        .offset(x:-20)
                    Spacer()
                }.padding(.top, 23.67)
                .padding(.bottom, 33)
            }.padding(.leading,20)
            
            Group{
                TextEditor(text: $text)
                    .focused($focus)
                    .font(.system(size: 18))
                    .overlay(
                        text.isEmpty ?
                        Text("\(type.placeholder)")
                            .font(.system(size:18,weight:.medium))
                            .foregroundColor(.gray300)
                            .padding(.top,9)
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
                        viewModel.deleteUser(text: text)
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
        .onReceive(viewModel.$isSuccessInquire){
            if $0{
                dismiss()
            }
        }.onReceive(viewModel.$isSuccessDeleteUser){
            if $0{
                dismiss()
            }
        }
    }
}

struct InquireView_Previews: PreviewProvider {
    static var previews: some View {
        InquireView(type:.inquire)
    }
}
