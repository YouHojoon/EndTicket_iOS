//
//  MyHomeVIew.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/09.
//

import SwiftUI

struct MyHomeView: View {
    @EnvironmentObject private var signInViewModel: SignInViewModel
    @State private var shouldShowAlert = false
    var body: some View {
        NavigationView{
            VStack(alignment:.leading,spacing:0){
//                Text("설정")
//                    .kerning(-0.5)
//                    .font(.system(size: 21,weight: .bold))
//                    .padding(.bottom,33)
//                
                
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
                Group{
                    NavigationLink{
                        
                    }label: {
                        
                        HStack{
                            Text("알림")
                            .font(.system(size: 16,weight: .medium))
                            Spacer()
                            Image(systemName:"chevron.forward")
                                .foregroundColor(.gray300)
                                .font(.system(size: 10.5))
                        }.foregroundColor(.black)
                    }.padding(.vertical,20)
                    Divider()
                }
                Group{
                    NavigationLink{
                        
                    }label: {
                        
                        HStack{
                            Text("알림")
                            .font(.system(size: 16,weight: .medium))
                            Spacer()
                            Image(systemName:"chevron.forward")
                                .foregroundColor(.gray300)
                                .font(.system(size: 10.5))
                        }.foregroundColor(.black)
                    }.padding(.vertical,20)
                    Divider()
                }
                Group{
                    NavigationLink{
                        
                    }label: {
                        
                        HStack{
                            Text("알림")
                            .font(.system(size: 16,weight: .medium))
                            Spacer()
                            Image(systemName:"chevron.forward")
                                .foregroundColor(.gray300)
                                .font(.system(size: 10.5))
                        }.foregroundColor(.black)
                    }.padding(.vertical,20)
                    Divider()
                }
                Group{
                    HStack{
                        Text("로그아웃")
                            .font(.system(size: 16,weight: .medium))
                        Spacer()
                        Image(systemName:"chevron.forward")
                            .foregroundColor(.gray300)
                            .font(.system(size: 10.5))
                    }.foregroundColor(.black)
                        .padding(.vertical,20)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            shouldShowAlert = true
                        }
                    Divider()
                }
                Group{
                    NavigationLink{
                        
                    }label: {
                        HStack{
                            Text("회원탈퇴")
                                .font(.system(size: 16,weight: .medium))
                            Spacer()
                            Image(systemName:"chevron.forward")
                                .foregroundColor(.gray300)
                                .font(.system(size: 10.5))
                        }.foregroundColor(.black)
                    } .padding(.vertical,20)
                    
                    
                    Divider()
                }
               Spacer()
                
                
            }.navigationBarHidden(true)
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
        }
        
    }
}

struct MyHomeVIew_Previews: PreviewProvider {
    static var previews: some View {
        MyHomeView()
    }
}
