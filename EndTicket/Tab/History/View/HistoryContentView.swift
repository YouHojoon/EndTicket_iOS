//
//  HistoryHomeContentView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/09.
//

import SwiftUI

struct HistoryContentView: View {
    private let type: HistoryType
    private let amount: Int
    @State private var shouldShowDetail = false
    init(type:HistoryType, amount: Int){
        self.type = type
        self.amount = amount
    }
    
    var body: some View {
        VStack(alignment:.leading,spacing:10){
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 85, height: 85)
                .padding(.top,5)
            Group{
                Text("\(type.rawValue)").font(.system(size: 16,weight: .bold))
                    .foregroundColor(.gray500)
                HStack{
                    Text("\(amount)개")
                        .font(.system(size: 26,weight: .bold))
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15.75, height: 8.64)
                        .foregroundColor(.gray200)
                        .frame(width: 20, height: 20)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            shouldShowDetail = true
                        }
                }.padding(.bottom, 20)
            }.padding(.horizontal,10)
        }.padding(.horizontal,5)
        .background(RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.05), radius: 15, x: 0, y: 4)
        ).fullScreenCover(isPresented:$shouldShowDetail){
            detail
        }
    }
    
    
    
    var image: Image{
        switch type {
        case .ticket:
            return Image("ticket_flag")
        case .imagine:
            return Image("futureOfMe_image")
        case .mission:
            return Image("mission")
        }
    }
    
    @ViewBuilder
    var detail: some View{
        switch type {
        case .ticket:
            TicketHistoryView()
        case .mission:
            MissionHistoryView()
        case .imagine:
            ImagineHistoryView()
        }
    }
}

struct HistoryHomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryContentView(type: .ticket, amount: 1)
    }
}
