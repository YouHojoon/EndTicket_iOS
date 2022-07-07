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
        LazyHGrid(rows: Array(repeating:GridItem(.fixed(52)), count:2), spacing: 11){
            ForEach(Color.ticketColors, id:\.self){color in
                Circle()
                    .foregroundColor(color)
                    .frame(width:40, height:40)
                    .padding(4)
                    .overlay(Circle().stroke(color == selected ? Color.gray300 : .clear, lineWidth:3))
                    .onTapGesture {
                        selected = color
                    }
            }
        }
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
