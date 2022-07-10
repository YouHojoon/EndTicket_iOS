//
//  TicketFormCategoryView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/17.
//

import SwiftUI

struct TicketFormCategoryView: View {
    @Binding private var selected: Ticket.Category
    private let isEssential:Bool
    init(selected:Binding<Ticket.Category>,isEssential:Bool = false){
        _selected = selected
        self.isEssential = isEssential
    }
    
    var body: some View {
        VStack(alignment:.leading, spacing: 4){
            HStack(spacing:1){
                Text("분류")
                if isEssential{
                    Text("*").foregroundColor(.red)
                }
            }.font(.interSemiBold(size: 16))
            
            ScrollView(.horizontal,showsIndicators:false){
                HStack(spacing:8){
                    ForEach(Ticket.Category.allCases,id:\.self){category in
                        Text(category.rawValue)
                            .font(.system(size: 14,weight:.bold))
                            .foregroundColor(category == selected ? Color.white : .gray600)
                            .padding(.horizontal,16)
                            .padding(.vertical,11)
                            .background(Capsule()
                                .foregroundColor(category == selected ? .black : .white))
                            .overlay(Capsule().stroke(
                                category == selected ? Color.clear :
                                Color.gray600,lineWidth: 1))
                            .padding(1)
                            .onTapGesture {
                                selected = category
                            }
                    }
                }
            }
        }
    }
}

struct TicketFormCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        TicketFormView().environmentObject(TicketViewModel())
    }
}