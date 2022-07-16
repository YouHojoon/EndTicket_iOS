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
    private let categorys = Ticket.Category.allCases.filter{$0 != .all}
    private let shouldRemoveAllCategory: Bool
    init(selected:Binding<Ticket.Category>,shouldShowTitle:Bool = true, isEssential:Bool = false, shouldRemoveAllCategory: Bool = true){
        _selected = selected
        self.isEssential = isEssential
        self.shouldShowTitle = shouldShowTitle
        self.shouldRemoveAllCategory = shouldRemoveAllCategory
    }
    
    var body: some View{
        VStack(alignment:.leading, spacing: 4){
            if shouldShowTitle{
                HStack(alignment:.top,spacing:2){
                    Text("분류")
                    if isEssential{
                        Image("essential_mark")
                            .padding(.top,2)
                    }
                }.font(.interBold(size: 16))
                .padding(.horizontal,20)
                .padding(.bottom, 10)
            }
            
            ScrollView(.horizontal,showsIndicators:false){
                HStack(spacing:8){
                    if !shouldRemoveAllCategory{
                        Text(Ticket.Category.all.rawValue)
                            .modifier(CategoryButtonModifier(.all,selected: $selected))
                    }
                    ForEach(categorys,id:\.self){category in
                        Text(category.rawValue)
                            .modifier(CategoryButtonModifier(category,selected: $selected))
                    }
                }.padding(.horizontal,20)
            }
        }
    }
}

fileprivate struct CategoryButtonModifier: ViewModifier{
    @Binding private var selected: Ticket.Category
    private let category: Ticket.Category
    init(_ category: Ticket.Category,selected:Binding<Ticket.Category>){
        _selected = selected
        self.category = category
    }
    func body(content: Content) -> some View {
        content.font(.system(size: 14,weight:.bold))
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
    }
}

struct TicketFormCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        TicketFormView().environmentObject(TicketViewModel())
    }
}
