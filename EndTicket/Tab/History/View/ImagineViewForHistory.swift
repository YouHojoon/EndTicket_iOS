//
//  ImagineViewForHistory.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/13.
//

import SwiftUI

struct ImagineViewForHistory: View {
    private let imagine: Imagine
    init(_ imagine: Imagine){
        self.imagine = imagine
    }
    var body: some View {
            TicketLeadingShape()
            .foregroundColor(.white)
            .cornerRadius(5)
            .overlay(
                RoundedCorner(radius: 5, corners: [.bottomLeft, .topLeft])
                    .frame(width:5)
                ,alignment: .leading)
            .cornerRadius(5)
            .shadow(color: Color(#colorLiteral(red: 0.4392156863, green: 0.5647058824, blue: 0.6901960784, alpha: 0.15)), radius: 20, x: 0, y: 5)
            .foregroundColor(imagine.color)
            .frame(height:87)
            .overlay{
                HStack(spacing:10){
                    Circle()
                        .frame(width:34, height: 34)
                        .foregroundColor(imagine.color)
                        .overlay{
                            Image("checkmark")
                                .renderingMode(.template)
                                .foregroundColor(.white)
                        }
                    VStack(alignment:.leading){
                        Text("\(imagine.subject)")
                            .font(.system(size:16,weight: .bold))
                        Spacer()
                        HStack(spacing:0){
                            Image("goal_icon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15, height: 15)
                                .padding(.trailing,3)
                            Text("\(imagine.purpose)")
                                .font(.system(size:12,weight: .semibold))
                                .padding(.trailing,31)
                            Spacer()
                            Text("\(imagine.updatedAt!)")
                                .font(.interSemiBold(size: 12))
                        }.foregroundColor(.gray500)
                    }
                }.padding(.horizontal,15)
                .padding(.top,23)
                .padding(.bottom,21)
            }
    }
}

struct ImagineViewForHistory_Previews: PreviewProvider {
    static var previews: some View {
        ImagineViewForHistory(Imagine.getDummys()[0])
    }
}
