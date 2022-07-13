//
//  TicketColorSelectView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/17.
//

import SwiftUI

struct ColorSelectView: View {
    @Binding private var selected: Color
    init(selected: Binding<Color>){
        _selected = selected
    }
    
    var body: some View {
        LazyVGrid(columns: Array(repeating:GridItem(.flexible(minimum:44)), count:6)){
            ForEach(Color.ticketColors, id:\.self){color in
                Circle().stroke(color == selected ? Color.gray300 : .clear, lineWidth:3)
                    .overlay{
                        Circle()
                            .foregroundColor(color)
                            .onTapGesture {
                                selected = color
                            }
                            .padding(4)
                    }.frame(height:44)
            }
        }
        .padding(.horizontal,20)
        .padding(.vertical, 30)
        .frame(maxWidth:.infinity,maxHeight:200)
        .background(.white)
        .cornerRadius(10)
        
    }
}

struct TicketColorSelectView_Previews: PreviewProvider {
    static var previews: some View {
        TicketFormView().environmentObject(TicketViewModel())
    }
}
