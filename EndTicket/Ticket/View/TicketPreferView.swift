//
//  TicketPreferView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/27.
//

import SwiftUI

struct TicketPreferView: View {
    @Binding private var tabIndex: EndTicketTabView.TabIndex
    @EnvironmentObject private var viewModel: TicketViewModel
    
    init(tabIndex:Binding<EndTicketTabView.TabIndex>){
        _tabIndex = tabIndex
    }
    
    var body: some View {
        VStack(alignment:.leading, spacing:0){
            HStack(spacing:0){
                Image(systemName: "arrow.backward")
                    .font(.system(size: 16))
                    .onTapGesture {
                        withAnimation{
                            tabIndex = .home
                        }
                    }
                Spacer()
                Text("추천티켓").font(.system(size: 21,weight: .bold))
                Spacer()
            }.padding(.bottom, 43)
            
            Text("마침.표 추천!")
                .font(.system(size: 18, weight: .bold))
                .padding(.bottom, 10)
            
            HStack{
                Spacer()
                if viewModel.preferTicket == nil{
                    EmptyView()
                }
                else{
                    TicketViewForPrefer(viewModel.preferTicket!)
                }
                Spacer()
            }
            .padding(.bottom, 30)
            
            Text("다른 사람들의 티켓은?")
                .font(.system(size: 18, weight: .bold))
                .padding(.bottom, 10)
            ScrollView(showsIndicators:false){
                LazyVStack(spacing:10){
                    ForEach(0..<Ticket.getDummys().count){
                        TicketViewForPrefer(Ticket.getDummys()[$0])
                    }
                }
            }
            
        }
        .padding(.horizontal, 20)
        .onAppear{
            viewModel.getPreferTicket()
        }
    }
}

struct TicketPreferView_Previews: PreviewProvider {
    static var previews: some View {
        EndTicketTabView()
    }
}
