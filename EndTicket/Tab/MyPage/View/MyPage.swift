//
//  MyHomeVIew.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/09.
//

import SwiftUI
import PDFKit
import Kingfisher
struct MyHomeView: View {
    @EnvironmentObject private var signInViewModel: SignInViewModel
//    @EnvironmentObject private var futureOfMeViewModel: FutureOfMeViewModel
    @EnvironmentObject private var viewModel : MyPageViewModel
    
    @State private var shouldShowAlert = false
    @State private var shouldShowInquireView = false
    @State private var shouldShowDeleteUserView = false
    @State private var shouldShowPersonalInformationProcessingPolicy = false
    @State private var imageUrl:URL? = nil
    
    var body: some View {
        VStack(alignment:.leading,spacing:0){
            HStack(spacing:15){
                if imageUrl == nil{
                    Circle()
                    .foregroundColor(.gray200)
                    .frame(width: 56, height: 56)
                       
                }
                else{
                    KFImage(imageUrl!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 56, height: 56)
                }
                
                VStack(alignment:.leading, spacing: 1){
                    Text("\(EssentialToSignIn.nickname.saved ?? "")")
                        .font(.system(size: 16, weight: .bold))
                    Text("\(EssentialToSignIn.email.saved ?? "")")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.gray400)
                }
            }.padding(.bottom,21)
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
            InquireView(type:.inquire).environmentObject(viewModel)
        }.fullScreenCover(isPresented: $shouldShowDeleteUserView){
            InquireView(type:.deleteUser)
        }
        .fullScreenCover(isPresented: $shouldShowPersonalInformationProcessingPolicy){
            PersonalInformationProcessingPolicyView()
        }
//        
//        .onAppear{
//            futureOfMeViewModel.fetchFutureOfMe()
//        }
//        .onReceive(futureOfMeViewModel.$futureOfMe.dropFirst()){
//            guard let futureOfMe = $0 else{
//                return
//            }
//            imageUrl = futureOfMe.characterImageUrl
//        }
    }
    
    
    
}

struct MyHomeVIew_Previews: PreviewProvider {
    static var previews: some View {
        MyHomeView()
    }
}
