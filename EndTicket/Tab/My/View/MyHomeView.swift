//
//  MyHomeVIew.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/09.
//

import SwiftUI

struct MyHomeView: View {
    
    var body: some View {
        NavigationView{
            VStack(alignment:.leading,spacing:0){
                Text("설정")
                    .kerning(-0.5)
                    .font(.gmarketSansMeidum(size: 20))
                    .padding(.bottom,24)
                
                
                List{
                    HStack(spacing:23){
                        Circle().frame(width: 56, height: 56)
                            .foregroundColor(Color(#colorLiteral(red: 0.8797428608, green: 0.8797428012, blue: 0.8797428608, alpha: 1)))
                        VStack(alignment:.leading, spacing: 5){
                            Text("별명")
                                .font(.gmarketSansMeidum(size: 16))
                            Text("dbghwns66@daum.net")
                                .font(.gmarketSansMeidum(size: 12))
                                .tint(Color(#colorLiteral(red: 0.758, green: 0.758, blue: 0.758, alpha: 1)))
                        }
                    }.padding(.vertical,5)
                        .listRowSeparator(.hidden,edges: .top)
                    
                    NavigationLink("알림"){
                        Text("알림")
                    }.font(.gmarketSansMeidum(size: 16))
                        .padding(.vertical)
                    NavigationLink("문의하기"){
                        Text("문의하기")
                    }.font(.gmarketSansMeidum(size: 16))
                        .padding(.vertical)
                    NavigationLink("개인정보처리방침"){
                        Text("개인정보처리방침")
                    }.font(.gmarketSansMeidum(size: 16))
                        .padding(.vertical)
                    NavigationLink("로그아웃"){
                        Text("로그아웃")
                    }.font(.gmarketSansMeidum(size: 16))
                        .padding(.vertical)
                    NavigationLink("회원탈퇴"){
                        Text("회원탈퇴")
                    }.font(.gmarketSansMeidum(size: 16))
                        .padding(.vertical)
                    
                }.listStyle(.plain)
            }.navigationBarHidden(true)
                .padding(.horizontal,20)
                .padding(.top,25)
        }
        
    }
}

struct MyHomeVIew_Previews: PreviewProvider {
    static var previews: some View {
        MyHomeView()
    }
}
