//
//  SignUpView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/05/30.
//

import SwiftUI

struct SignUpView: View {
    private let textFieldNormalBorderColor = Color(#colorLiteral(red: 0.9150597453, green: 0.9150596857, blue: 0.9150597453, alpha: 1))
    private let textFieldWarningBoarderColor = Color(#colorLiteral(red: 0.9989913106, green: 0.5363228321, blue: 0.5204564333, alpha: 1))
    private let disabledButtonColor = Color(#colorLiteral(red:0.758,green:0.758,blue:0.758,alpha:1))
    private let enabledButtonColor = Color(#colorLiteral(red: 0.3407235146, green: 0.4472774267, blue: 1, alpha: 1))
    
    @EnvironmentObject private var viewModel:SignUpViewModel
    @State private var isTextFieldNormalBorder = true
    @State private var isButtonEnable = true
    @State private var isTextFieldMessageHidden = true
    @State private var isKeyboardShow = false
    @State private var shouldShowNextView = false
    @FocusState private var isTextFieldFocus
    
    var body: some View {
            VStack(spacing: 0){
                Text("별명을 지어주세요!")
                    .kerning(-0.5)
                    .font(.interSemiBold(size: 14))
                    .padding(.bottom, 10)
                    .foregroundColor(.gray900)
                    .frame(width: 335,height: 25,alignment: .leading)
                    
                TextField("한글, 영어, 숫자를 포함한 8자 까지만 가능합니다:)", text: $viewModel.nickname, onCommit: {
                    isTextFieldFocus = false
                }).autocapitalization(.none)
                    .disableAutocorrection(true)
                    .font(.gmarketSansMeidum(size: 10))
                    .focused($isTextFieldFocus)
                    .padding()
                    .frame(width: 335, height: 50)
                    .background(
                        Color.white.onTapGesture {
                            //TextField 터치 가능 영역을 넓히기 위함
                            isTextFieldFocus = true
                        }
                    )
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(isTextFieldNormalBorder ? textFieldNormalBorderColor : textFieldWarningBoarderColor))
                    .onReceive(viewModel.isNicknameStatisfied.dropFirst()){
                        isTextFieldNormalBorder = $0
                        isTextFieldMessageHidden = false
                    }
                //MARK: - 닉네임 관련 알림
                if !isTextFieldMessageHidden{
                    Text(isTextFieldNormalBorder ? "멋진 별명이네요!" : "별명을 다시 한 번 확인해주세요.")
                        .kerning(-0.54)
                        .font(.gmarketSansMeidum(size: 10))
                        .frame(width: 254, height: 30, alignment: .leading).foregroundColor(isTextFieldNormalBorder ? enabledButtonColor : textFieldWarningBoarderColor)
                }
                Spacer()
                Button{
                    isTextFieldFocus = false
                    withAnimation(.easeInOut){
                        shouldShowNextView = true
                    }
                }label: {
                    Text("등록하기")
                        .foregroundColor(.white)
                        .font(.gmarketSansMeidum(size: 20))
                        .frame(maxWidth:.infinity, maxHeight: 56)
                }.background(isButtonEnable ? enabledButtonColor : disabledButtonColor)
                    .cornerRadius(10)
                    .padding(.bottom, isKeyboardShow ? 15 : 0)
                    .onReceive(viewModel.isNicknameStatisfied){
                        isButtonEnable = $0
                    }
                    .disabled(!isButtonEnable)
            }
            .padding(.top,157)
                .padding(.horizontal, 30)
                .listenKeyBoardShowAndHide($isKeyboardShow)
                .background(Color.white.ignoresSafeArea().onTapGesture {
                    isTextFieldFocus = false
                })
                .overlay{
                    shouldShowNextView ? EndTicketTabView().background(Color.white).transition(.move(edge: .trailing)) : nil
                }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(SignUpViewModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
    }
}
