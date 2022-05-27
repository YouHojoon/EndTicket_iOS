//
//  OnBoarding.swift
//  EndTicket
//
//  Created by 유호준 on 2022/05/27.
//

import SwiftUI

//MARK: - OnBoarding 통합 뷰
struct OnBoardingView<NextView:View>: View {
    
    private let title:String
    private let font = Font.custom("GmarketSansMedium", size: 20)
    private let nextView:NextView
    
    @State private var shouldShowNextView = false
    init(_ title:String, @ViewBuilder nextView: ()-> NextView){
        self.title = title
        self.nextView = nextView()
    }
    
    var body: some View {
        VStack{
            Text(title)
                .kerning(-0.54)
                .font(font)
                .multilineTextAlignment(.center)
                .lineSpacing(10)
                .padding(.bottom, 92)
                
            ZStack(alignment:.bottomTrailing){
                RoundedRectangle(cornerRadius: 17)
                    .foregroundColor(.gray.opacity(0.5))
                Button{
                    withAnimation(.easeInOut){
                        shouldShowNextView = true
                    }
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
            .background(Color.white)
            .overlay(shouldShowNextView ? nextView.transition(.opacity): nil)
            
            
    }
}
