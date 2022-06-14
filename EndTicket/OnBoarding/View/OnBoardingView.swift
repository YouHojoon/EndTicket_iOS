//
//  OnBoarding.swift
//  EndTicket
//
//  Created by 유호준 on 2022/05/27.
//

import SwiftUI

//MARK: - OnBoarding 통합 뷰
struct OnBoardingView: View {
    @State private var index = 0
    var body: some View {
        VStack{
            Spacer()
            ZStack{//opacity가 변하면서 바뀌는 것을 원해서 ZStack으로
                ForEach(OnBoarding.allCases, id:\.self){onBoarding in
                    VStack{
                        onBoarding.image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:350,height: 300)
                            
                        Text(onBoarding.title)
                            .kerning(-0.54)
                            .font(.gmarketSansMeidum(size: 20))
                            .multilineTextAlignment(.center)
                            .lineSpacing(10)
                    }.opacity(index == onBoarding.index ? 1 : 0)
                }
            }.padding(.bottom,110)
            
            Button{
                if index != OnBoarding.allCases.count - 1{
                    withAnimation{
                        index += 1
                    }
                }
                else{
                    withAnimation{
                        UserDefaults.standard.setValue(false, forKey: "isFirstStart")
                    }
                }
            }label: {
                OnBoarding.allCases[index]
                    .buttonLabel
                    .foregroundColor(.white)
                    .font(.appleSDGothicBold(size: 15))
                    .frame(width:335, height: 50)
            }
            .animation(nil, value: index)
            .background(Color.mainColor)
            .cornerRadius(10)
            .padding(.bottom, 20)
            
            HStack{
                ForEach(0 ..< OnBoarding.allCases.count){
                    Capsule()
                        .frame(width: $0 == index ? 40 : 10, height: 10)
                        .foregroundColor(Color.mainColor)
                }
            }.padding(.bottom,60)
        }.padding(.horizontal, 25)
        .padding(.top, 107)
        .background(Color.white)
    }
}
struct OnBoarding_Previews:PreviewProvider{
    static var previews: some View{
        LoginView_Previews.previews
    }
}
