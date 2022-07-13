//
//  TicketFormCategoryView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/17.
//

import SwiftUI
import Foundation
struct TicketCategorySelectView: View {
    @Binding private var selected: Ticket.Category
    private let isEssential: Bool
    private let shouldShowTitle: Bool
    private let categorys:[Ticket.Category]
    init(selected:Binding<Ticket.Category>,shouldShowTitle:Bool = true, isEssential:Bool = false, shouldRemoveAllCategory: Bool = true){
        _selected = selected
        self.isEssential = isEssential
        self.shouldShowTitle = shouldShowTitle
        
        var categorys = Ticket.Category.allCases
        if shouldRemoveAllCategory{
            let index = categorys.firstIndex(of: .all)!
            categorys.remove(at: index)
        }
        self.categorys = categorys
    }
    
    var body: some View{
        VStack(alignment:.leading, spacing: 4){
            if shouldShowTitle{
                HStack(spacing:1){
                    Text("분류")
                    if isEssential{
                        Text("*").foregroundColor(.red)
                    }
                }.font(.interSemiBold(size: 16))
                .padding(.horizontal,20)
                .padding(.bottom, 10)
            }
            ScrollView(.horizontal,showsIndicators:false){
                HStack(spacing:8){
                    ForEach(categorys,id:\.self){category in
                        Text(category.rawValue)
                            .font(.system(size: 14,weight:.bold))
                            .foregroundColor(category == selected ? Color.white : .gray600)
                            .padding(.horizontal,16)
                            .padding(.vertical,11)
                            .background(Capsule()
                                .foregroundColor(category == selected ? .black : .white))
                            .overlay(Capsule().stroke(
                                category == selected ? Color.clear :
                                    Color.gray100,lineWidth: 1))
                            .padding(1)
                            .onTapGesture {
                                selected = category
                            }
                        Spacer()
                    }
                }.padding(.horizontal,20)
            }
        }
//        .padding(.horizontal,20)
    }
}

struct TicketFormCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        TicketFormView().environmentObject(TicketViewModel())
    }
}
