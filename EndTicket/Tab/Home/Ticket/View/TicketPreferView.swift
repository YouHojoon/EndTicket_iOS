//
//  TicketPreferView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/27.
//

import SwiftUI

struct TicketPreferView: View {
    @EnvironmentObject private var viewModel: TicketViewModel
    @State private var othersTickets:[Ticket] = []
    @State private var preferTicket: Ticket? = nil
    var body: some View {
        VStack(alignment:.leading, spacing:0){
            ZStack{
                Color.gray10.ignoresSafeArea()
                VStack(alignment:.leading, spacing:0){
                    HStack{
                        VStack(alignment:.leading,spacing:4){
                            Text("다른 사람 티켓은 어떨까?")
                                .font(.system(size: 12,weight: .bold))
                                .foregroundColor(.gray500)
                            Text("공감가는 티켓을 추가해보세요!")
                                .font(.system(size: 18,weight: .bold))
                                .foregroundColor(.black)
                        }
                        Spacer()
                        Image("ticket_thumb")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:105,height: 90)
                    }.padding(.bottom,15)
                    .padding(.top, 20)
                    Text("마침.표 추천!")
                        .font(.system(size: 18, weight: .bold))
                        .padding(.bottom, 10)
                    HStack{
                        Spacer()
                        if preferTicket == nil{
                            EmptyView()
                        }
                        else{
                            TicketViewForPrefer(preferTicket!)
                        }
                        Spacer()
                    }
                    .padding(.bottom, 30)
                    Text("다른 사람들의 티켓은?")
                        .font(.system(size: 18, weight: .bold))
                        .padding(.bottom, 10)
                    ScrollView(showsIndicators:false){
                        LazyVStack(spacing:10){
                            ForEach(othersTickets, id: \.id){
                                TicketViewForPrefer($0)
                            }
                        }.padding(.vertical)
                    }
                }.padding(.horizontal, 20)
            }
        }
        .onReceive(viewModel.$preferTicket){
            if $0 != nil{
                self.preferTicket = $0
            }
        }
        .onReceive(viewModel.$othersTickets){
            if $0.count != 0{
                self.othersTickets = $0
            }
        }
        .onAppear{
            viewModel.fetchPreferTicket()
            viewModel.fetchOthersTickets()
        }
    }
}

struct TicketPreferView_Previews: PreviewProvider {
    static var previews: some View {
        EndTicketTabView(needSignUpCharacter: false)
    }
}
