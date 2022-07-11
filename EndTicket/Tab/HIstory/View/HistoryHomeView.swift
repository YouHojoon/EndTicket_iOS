//
//  HistoryHomeView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/09.
//

import SwiftUI

struct HistoryHomeView: View {
    var body: some View {
        VStack(alignment:.leading,spacing:0){
//            Text("기록")
//                .kerning(-0.5)
//                .font(.gmarketSansMeidum(size: 20))
//                .padding(.bottom,24)
            Text("지금까지")
                .font(.gmarketSansMeidum(size: 20))
                .padding(.bottom)
            (Text("124")
                .font(.gmarketSansMeidum(size: 60)) + Text("회 터치").font(.gmarketSansMeidum(size: 20)))
            .kerning(-0.5)
            .padding(.bottom)
            
            HStack(spacing:20){
                HistoryHomeContentView()
                    .frame(width:160, height: 205)
                HistoryHomeContentView()
                    .frame(width:160, height: 205)
            }.padding(.bottom,41)
            
            HistoryHomeContentView()
                .frame(width:340, height: 178)
            Spacer()
        }.padding(.horizontal,20)
            .padding(.top,25)
    }
}

struct HistoryHomeView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryHomeView()
    }
}
