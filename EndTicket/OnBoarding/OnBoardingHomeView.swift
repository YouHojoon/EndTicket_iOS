//
//  OnBoarding.swift
//  EndTicket
//
//  Created by 유호준 on 2022/05/27.
//

import SwiftUI

struct OnBoardingHomeView: View {
    let font = Font.custom("GmarketSansMedium", size: 20)
    
    var body: some View {
        VStack{
            Text("티켓을 터치할 때마다 목적지에\n가까워질 수 있어요!\n티켓을 만들어보고 목표를 달성해보세요.")
                .kerning(-0.54)
                .font(font)
                .multilineTextAlignment(.center)
                .lineSpacing(10)
                .padding(.bottom, 92)
                
            ZStack(alignment:.bottomTrailing){
                RoundedRectangle(cornerRadius: 17)
                    .foregroundColor(.gray.opacity(0.5))
                Button{
                    
                }label: {
                    Text("다음")
                        .font(font)
                        .foregroundColor(.white)
                }.padding()
                    .frame(width:100, height: 56)
                    .background(Color.gray)
                    .cornerRadius(8)
                    .padding(.trailing, 15)
                    .padding(.bottom, 54)
            }
        }.padding(.horizontal, 25)
            .padding(.top, 107)
    }
}

struct OnBoardingHomeView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingHomeView()
    }
}
