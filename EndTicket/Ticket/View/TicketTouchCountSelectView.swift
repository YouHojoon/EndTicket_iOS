//
//  TicketTouchCountSelectView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/17.
//

import SwiftUI

struct TicketTouchCountSelectView: View {
    private let touchCounts = [5,10,15]
    private let buttonGrayColor = Color(#colorLiteral(red: 0.8797428608, green: 0.8797428012, blue: 0.8797428608, alpha: 1))
    
    @Binding private var selected: Int
    
    init(selected:Binding<Int>){
        _selected = selected
    }
    
    var body: some View {
        VStack(alignment:.leading,spacing:4){
            Text("터치횟수")
                .font(.interSemiBold(size: 16))
            
            HStack{
                ForEach(0..<touchCounts.count){index in
                    VStack(spacing:8.94){
                        let touchCount = touchCounts[index]
                        
                        Text("\(touchCounts[index])회").font(.gmarketSansMeidum(size: 16))
                        Circle().stroke(touchCount == selected ? .mainColor : buttonGrayColor, lineWidth:1.5)
                            .frame(width:13.33,height:13.33)
                            .overlay(Circle()
                                .frame(width:8,height:8)
                                .foregroundColor(touchCount == selected ? .mainColor : buttonGrayColor))
                            .onTapGesture{
                                selected = touchCounts[index]
                            }
                    }.padding(.vertical, 20)
                        .padding(.horizontal, 33)
                    
                    if index < touchCounts.count - 1 {
                        Spacer()
                    }
                }
            }.background(.white)
                .cornerRadius(10)
        }
    }
}

struct TicketTouchCountSelectView_Previews: PreviewProvider {
    static var previews: some View {
        TicketFormView()
    }
}
