//
//  HistoryHomeContentView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/09.
//

import SwiftUI

struct HistoryHomeContentView: View {
    
    var body: some View {
        VStack(alignment:.leading,spacing:0){
            Text("티켓").font(.gmarketSansMeidum(size: 15))
                .padding(.bottom,20)
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color(#colorLiteral(red: 0.8010819554, green: 0.8010819554, blue: 0.8010819554, alpha: 1)))
                .overlay{
                    HStack(alignment:.top){
                        Circle()
                            .frame(width: 75, height: 75)
                            .foregroundColor(Color(#colorLiteral(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)))
                        Spacer()
                        VStack(alignment:.trailing){
                            Circle().frame(width:24,height: 24)
                                .foregroundColor(Color(#colorLiteral(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)))
                                .overlay{
                                    Image(systemName: "chevron.forward")
                                        .font(.system(size: 18,weight:.bold))
                                        .foregroundColor(Color(#colorLiteral(red: 0.8010819554, green: 0.8010819554, blue: 0.8010819554, alpha: 1)))
                                }
                            Spacer()
                            (Text("13")
                                .font(.gmarketSansMeidum(size: 40))
                             + Text("개")
                                .font(.gmarketSansMeidum(size: 15))
                            ).kerning(-0.5)
                            .frame(width:58)
                        }
                    }.padding(10)
                }
        }
    }
}

struct HistoryHomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryHomeContentView()
    }
}
