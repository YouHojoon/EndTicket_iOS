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
    @FocusState private var isTextFieldFocus
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment:.leading,spacing: 0){
                Image(systemName: "arrow.backward")
                    .font(.system(size:15, weight: .medium))
                    .contentShape(Rectangle())
                    .frame(width:30,height: 30, alignment: .leading)
                    .onTapGesture {
                        dismiss()
                    }
                    .padding(.bottom,31)

                
                Text("별명을 지어주세요!")
                    .kerning(-0.5)
                    .font(.interSemiBold(size: 18))
                    .padding(.bottom, 10)
                    .foregroundColor(.gray900)
                    .frame(height: 25,alignment: .leading)
                
                TextField("한글, 영어, 숫자를 포함한 8자 까지만 가능합니다:)", text: $viewModel.nickname, onCommit: {
                    isTextFieldFocus = false
                }).autocapitalization(.none)
                    .disableAutocorrection(true)
                    .font(.system(size: 14,weight: .bold))
                    .focused($isTextFieldFocus)
                    .padding()
                    .frame(height: 50)
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
                        .font(.system(size: 14, weight: .bold))
                        .frame(width: 335, height: 30, alignment: .leading).foregroundColor(isTextFieldNormalBorder ? .mainColor : .red)
                }
                Spacer()
                Button{
                    isTextFieldFocus = false
                    viewModel.signUpNickname()
                }label: {
                    Text("등록하기")
                        .foregroundColor(.white)
                        .font(.system(size: 15,weight: .bold))
                        .frame(maxWidth: .infinity, maxHeight: 56)
                }.background(isButtonEnable ? Color.mainColor : Color.gray300)
                    .cornerRadius(10)
                    .padding(.bottom, isKeyboardShow ? 15 : 0)
                    .onReceive(viewModel.isNicknameStatisfied){
                        isButtonEnable = $0
                    }
                    .disabled(!isButtonEnable)
            }
        }
        
        .padding(.top,27)
        .padding(.horizontal, 30)
        .frame(maxWidth:.infinity)
        .onTapGesture {
            hideKeyboard()
        }
        
        .listenKeyBoardShowAndHide($isKeyboardShow)
        .onReceive(viewModel.$isSuccessSignUpNickname.dropFirst()){
            if $0{
                dismiss()
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(SignUpViewModel())

    }
}
