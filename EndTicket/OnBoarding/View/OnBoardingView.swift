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
            Text("건너뛰기")
                .underline()
                .foregroundColor(Color.gray500)
                .font(.system(size:13,weight: .medium))
                .padding(.bottom,36)
                .frame(maxWidth:.infinity,alignment: .trailing)
                .onTapGesture{
                    withAnimation{
                        UserDefaults.standard.setValue(false, forKey: "isFirstStart")
                    }
                }.padding([.top,.trailing],20)
            
            ZStack{//opacity가 변하면서 바뀌는 것을 원해서 ZStack으로
                ForEach(OnBoarding.allCases, id:\.self){onBoarding in
                    VStack(spacing:0){
                        Text(onBoarding.title)
                            .font(.system(size: 18,weight: .bold))
                            .padding(.bottom, 10)
                        Text(onBoarding.content)
                            .kerning(-0.54)
                            .font(.system(size: 16,weight: .bold))
                            .foregroundColor(.gray500)
                            .multilineTextAlignment(.center)
                        onBoarding.image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }.opacity(index == onBoarding.index ? 1 : 0)
                    .padding(.horizontal, 20)
                }
            }.padding(.bottom,20)
            
            HStack{
                ForEach(0 ..< OnBoarding.allCases.count){
                    Capsule()
                        .frame(width: $0 == index ? 40 : 10, height: 10)
                        .foregroundColor($0 == index ? Color.mainColor : Color(uiColor: #colorLiteral(red: 0.8116570115, green: 0.9145198464, blue: 0.9533794522, alpha: 1)))
                }
            }.padding(.bottom,30)
            
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
                    .font(.system(size:15,weight:.bold))
                    .frame(maxWidth:.infinity,maxHeight:50)
                    
            }
            .animation(nil, value: index)
            .background(Color.mainColor)
            .cornerRadius(10)
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            Spacer()
            
        }
        .padding(.top, 20)
        .background(Color.white)
    }
}
struct OnBoarding_Previews:PreviewProvider{
    static var previews: some View{
        OnBoardingView()
    }
}
