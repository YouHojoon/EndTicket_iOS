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
    private let abledButtonColor = Color(#colorLiteral(red: 0.3407235146, green: 0.4472774267, blue: 1, alpha: 1))
    
    @EnvironmentObject private var viewModel:SignUpViewModel
    @State private var isTextFieldNormalBorder = true
    @State private var isButtonEnable = true
    
    var body: some View {
        VStack(spacing: 0){
            Text("별명을 지어주세요").kerning(-0.43).font(.gmarketSansMeidum(size: 16)).padding(.bottom, 7)
                .frame(width: 284,alignment: .leading)
            TextField("한글, 영어, 숫자를 포함한 8자 까지만 가능합니다:)", text: $viewModel.nickname)
                .font(.gmarketSansMeidum(size: 10))
                .padding()
                .frame(width: 284, height: 48)
                .background(RoundedRectangle(cornerRadius: 4).stroke(isTextFieldNormalBorder ? textFieldNormalBorderColor : textFieldWarningBoarderColor))
                .onReceive(viewModel.isNicknameStatisfied.dropFirst()){
                    isTextFieldNormalBorder = $0
                }
                
            Spacer()
            Button{
                
            }label: {
                Text("등록하기")
                    .foregroundColor(.white)
                    .font(.gmarketSansMeidum(size: 20))
                    .frame(maxWidth:.infinity, maxHeight: 56)
            }.background(disabledButtonColor)
                .cornerRadius(10)
        }.padding(.top,157)
            .padding(.horizontal, 30)
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(SignUpViewModel())
    }
}
