//
//  SignUpView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/05/30.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var viewModel: SignUpViewModel
    
    @State private var isTextFieldNormalBorder = true
    @State private var isButtonEnable = true
    @State private var isTextFieldMessageHidden = true
    @State private var isKeyboardShow = false
    @State private var shouldShowNextView = false
    @FocusState private var isTextFieldFocus
    
    var body: some View {
        VStack(alignment:.leading,spacing: 0){
            Image(systemName: "arrow.backward")
                .font(.system(size:15, weight: .medium))
                .frame(width:30,height: 30, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    dismiss()
                    
                }
                .padding(.bottom,31)

            
            Text("별명을 지어주세요!")
                .kerning(-0.5)
                .font(.interSemiBold(size: 18))
                .padding(.bottom, 10)
                .foregroundColor(.gray900)
                .frame(width: 335,height: 25,alignment: .leading)
            
            TextField("한글, 영어, 숫자를 포함한 8자 까지만 가능합니다:)", text: $viewModel.nickname, onCommit: {
                isTextFieldFocus = false
            }).autocapitalization(.none)
                .disableAutocorrection(true)
                .font(.appleSDGothicBold(size: 14))
                .focused($isTextFieldFocus)
                .padding()
                .frame(width: 335, height: 50)
                .background(
                    Color.white.onTapGesture {
                        //TextField 터치 가능 영역을 넓히기 위함
                        isTextFieldFocus = true
                    }
                )
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(isTextFieldNormalBorder ? Color.gray100 : Color.red))
                .onReceive(viewModel.isNicknameStatisfied.dropFirst()){
                    isTextFieldNormalBorder = $0
                    isTextFieldMessageHidden = false
                }
                .padding(.bottom,10)
            //MARK: - 닉네임 관련 알림
            if !isTextFieldMessageHidden{
                Text(isTextFieldNormalBorder ? "멋진 별명이네요!" : "별명을 다시 한 번 확인해주세요.")
                    .kerning(-0.54)
                    .font(.gmarketSansMeidum(size: 14))
                    .frame(width: 335, height: 30, alignment: .leading).foregroundColor(isTextFieldNormalBorder ? .mainColor : .red)
            }
            Spacer()
            Button{
                isTextFieldFocus = false
                viewModel.signUp()
            }label: {
                Text("등록하기")
                    .foregroundColor(.white)
                    .font(.appleSDGothicBold(size: 15))
                    .frame(maxWidth: 335, maxHeight: 56)
            }.background(isButtonEnable ? Color.mainColor : Color.gray300)
                .cornerRadius(10)
                .padding(.bottom, isKeyboardShow ? 15 : 0)
                .onReceive(viewModel.isNicknameStatisfied){
                    isButtonEnable = $0
                }
                .disabled(!isButtonEnable)
        }
        .padding(.top,27)
        .padding(.horizontal, 30)
        .frame(maxWidth:.infinity)
        .fullScreenCover(isPresented: $shouldShowNextView){
            EndTicketTabView().environmentObject(TicketViewModel())
        }
        .listenKeyBoardShowAndHide($isKeyboardShow)
        .background(Color.white.ignoresSafeArea().onTapGesture {
            isTextFieldFocus = false
        })
        .onReceive(viewModel.$isSuccessSignUp.dropFirst()){
            if $0{
                withAnimation(.easeInOut){
                    shouldShowNextView = true
                }
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(SignUpViewModel())
         
    
    }
}
