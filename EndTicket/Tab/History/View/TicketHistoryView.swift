//
//  TicketHistoryView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/12.
//

import SwiftUI

struct TicketHistoryView: View {
    @State private var category: Ticket.Category = .all
    @State private var isNotScrolled = true
    @EnvironmentObject private var viewModel: HistoryViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment:.leading, spacing:0){
            HistoryType.ticket.headContent(dismiss: dismiss,isNotScrolled: $isNotScrolled ,selected: $category)
            HistoryType.ticket.mainContent(isNotScrolled:$isNotScrolled){
                ForEach(viewModel.ticketHistories,id:\.id){
                    TicketViewForHistory($0)
                }
            }
        }.onAppear{
            viewModel.fetchTicketHistory(category: category)
        }.onChange(of: category){
            viewModel.fetchTicketHistory(category: $0)
        }
    }
}

struct TicketHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        TicketHistoryView()
    }
}
