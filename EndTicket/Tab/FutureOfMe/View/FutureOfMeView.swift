//
//  FutureOfMeView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/08.
//

import SwiftUI

struct FutureOfMeView: View {
    
    init(){
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        VStack(spacing:0){
            //MARK: - 상단 프로필
            FutureOfMeProfileView()
                .padding(.bottom ,35)
            
            //MARK: - 상상해보기
            Group{
                HStack{
                    Text("상상해보기")
                        .font(.appleSDGothicBold(size: 16))
                    Spacer()
                    Button{
                        
                    }label: {
                        Image(systemName: "plus")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(Color(#colorLiteral(red: 0.7568627451, green: 0.7568627451, blue: 0.7568627451, alpha: 1)))
                    }
                }.padding(.bottom,12)
                Divider().padding(.bottom, 21)
                
                ScrollView(showsIndicators:false){
                    VStack(spacing:5){
                            ForEach(0..<5){index in
                                ImagineView(index)
                                .padding(.horizontal)
                        }
                    }
                }
            }.padding(.horizontal, 25)
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)).ignoresSafeArea())
    }
}

struct FutureOfMeView_Previews: PreviewProvider {
    static var previews: some View {
        FutureOfMeView().environmentObject(ImagineViewModel())
    }
}
