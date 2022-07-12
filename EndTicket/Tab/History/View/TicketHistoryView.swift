//
//  TicketHistoryView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/12.
//

import SwiftUI

struct TicketHistoryView: View {
    @State private var category: Ticket.Category = .all
    @EnvironmentObject private var viewModel: HistoryViewModel
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(alignment:.leading, spacing:0){
            VStack(alignment: .leading, spacing:0){
                Group{
                    HStack{
                       Image(systemName: "arrow.backward")
                            .font(.system(size:15, weight: .medium))
                            .padding(.trailing,13)
                            .onTapGesture {
                                dismiss()
                            }
                        Spacer()
                        Text("티켓")
                            .font(.system(size: 21,weight: .bold))
                        Spacer()
                    }.padding(.top, 23.67)
                        .padding(.bottom, 43)
                    
                    Text("잘하셨어요!\n앞으로 더 기대 되는걸요:)")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 22,weight: .bold))
                    .padding(.bottom,20)
                }.padding(.horizontal,20)
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        TicketCategorySelectView(selected: $category,shouldShowTitle:false,isEssential:false, shouldRemoveAllCategory:false)
                    }.padding(.horizontal,20)
                }.padding(.bottom,15)
            }
            .background(Color.white.edgesIgnoringSafeArea(.horizontal))

            ZStack{
                Color.gray10.ignoresSafeArea()
                ScrollView{
                    LazyVStack{
                        ForEach(viewModel.ticketHistories,id:\.id){
                            TicketViewForHistory($0)
                        }
                        Spacer()
                    }.padding(.top, 30)
                        .padding(.horizontal, 20)
                }
            }
        }.onAppear{
            viewModel.fetchTicketHistory(category: category)
        }
    }
}

struct TicketHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        TicketHistoryView()
    }
}
