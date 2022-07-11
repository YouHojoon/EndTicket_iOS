//
//  ImagineView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/09.
//

import SwiftUI

struct ImagineView: View {
    private let imagine: Imagine
    private let buttonBoderColor = Color(#colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1))
    
    @State private var shouldShowModifyView = false
    @EnvironmentObject private var viewModel: FutureOfMeViewModel
    
    init(_ imagine: Imagine){
        self.imagine = imagine
    }
    
    var body: some View {
        HStack(spacing:15){
            Button{
                viewModel.touchImagine(id: imagine.id)
            }label:{
                Circle()
                    .frame(width:34, height: 34)
                    .foregroundColor(.white)
                    .overlay{
                            Circle().stroke(buttonBoderColor, lineWidth: 2)
                    }
                    .overlay{
                        Image("checkmark")
                            .renderingMode(.template)
                            .foregroundColor(imagine.color)
                    }
            }.padding(.horizontal,1)
            
            VStack(alignment: .leading, spacing:3){
                Text(imagine.subject).font(.system(size:16,weight: .bold))
                    .frame(height:20)
                    .foregroundColor(.black)
                
                HStack(spacing:3){
                    Image("goal_icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:15,height: 15)
                    
                    Text(imagine.purpose)
                        .font(.system(size: 12,weight: .regular))
                }
                .frame(height:20)
                .foregroundColor(.gray500)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray300)
                .font(.system(size: 10.5))
                .contentShape(Rectangle())
                .frame(width:20,height: 20)
                .onTapGesture {
                    withAnimation{
                        shouldShowModifyView = true
                    }
                }
        }
        .frame(height:43)
        .fullScreenCover(isPresented:$shouldShowModifyView){
            ImagineFormView(imagine)
        }
    }
}

struct ImagineView_Previews: PreviewProvider {
    static var previews: some View {
        ImagineView(Imagine.getDummys()[0])
    }
}

