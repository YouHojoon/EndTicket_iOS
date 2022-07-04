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
            }.padding(.bottom, 13)
                .padding(.horizontal, 20)
                .background(Color.white)
            
            
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
                        Image("on_boarding_3")
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
                        }.padding(.vertical)
                    }
                }.padding(.horizontal, 20)
            }
           
            
        }

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
