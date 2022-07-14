//
//  MyHomeVIew.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/09.
//

import SwiftUI
import PDFKit

struct MyHomeView: View {
    @EnvironmentObject private var signInViewModel: SignInViewModel
    @State private var shouldShowAlert = false
    @State private var shouldShowInquireView = false
    @State private var shouldShowDeleteUserView = false
    @State private var shouldShowPersonalInformationProcessingPolicy = false
    
    var body: some View {
        VStack(alignment:.leading,spacing:0){
            HStack(spacing:23){
                Circle().frame(width: 56, height: 56)
                    .foregroundColor(.gray50)
                VStack(alignment:.leading, spacing: 5){
                    Text("별명")
                        .font(.gmarketSansMeidum(size: 16))
                    Text("dbghwns66@daum.net")
                        .font(.gmarketSansMeidum(size: 12))
                        .tint(Color(#colorLiteral(red: 0.758, green: 0.758, blue: 0.758, alpha: 1)))
                }
            }.padding(.bottom,29)
            Divider()
            //MARK: - 알림
            //                Group{
            //                    NavigationLink{
            //
            //                    }label: {
            //
            //                        HStack{
            //                            Text("알림")
            //                            .font(.system(size: 16,weight: .medium))
            //                            Spacer()
            //                            Image(systemName:"chevron.forward")
            //                                .foregroundColor(.gray300)
            //                                .font(.system(size: 10.5))
            //                        }.foregroundColor(.black)
            //                    }.padding(.vertical,20)
            //                    Divider()
            MyPageSection(title: "문의하기")
                .onTapGesture{
                    shouldShowInquireView = true
                }
            MyPageSection(title: "개인정보처리방침")
                .onTapGesture{
                    shouldShowPersonalInformationProcessingPolicy = true
                }
            MyPageSection(title:"로그아웃").onTapGesture {
                shouldShowAlert = true
            }
            MyPageSection(title:"회원탈퇴")
                .onTapGesture{
                    shouldShowDeleteUserView = true
                }
            Spacer()
        }
        .padding(.horizontal,20)
        .padding(.top,25)
        .alert(isPresented: $shouldShowAlert){
            EndTicketAlertImpl{
                Text("로그아웃 하시겠습니까?").font(.system(size: 18,weight: .bold))
                    .multilineTextAlignment(.center)
            } primaryButton:{
                EndTicketAlertButton(label:Text("취소").foregroundColor(.gray600)){
                    shouldShowAlert = false
                }
            }secondaryButton: {
                EndTicketAlertButton(label:Text("로그아웃").foregroundColor(.red)){
                    shouldShowAlert = false
                    signInViewModel.disconnect()
                }
            }
        }
        .fullScreenCover(isPresented: $shouldShowInquireView){
            InquireView(type:.inquire)
        }.fullScreenCover(isPresented: $shouldShowDeleteUserView){
            InquireView(type:.deleteUser)
        }.fullScreenCover(isPresented: $shouldShowPersonalInformationProcessingPolicy){
            PersonalInformationProcessingPolicyView()
        }
    }
    
    
    
}

struct MyHomeVIew_Previews: PreviewProvider {
    static var previews: some View {
        MyHomeView()
    }
}
