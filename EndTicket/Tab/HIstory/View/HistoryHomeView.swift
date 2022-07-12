//
//  HistoryHomeView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/09.
//

import SwiftUI

struct HistoryHomeView: View {
    @EnvironmentObject private var viewModel: HistoryViewModel
    var body: some View {
        VStack(alignment:.leading, spacing:0){
            (Text("\(UserDefaults.standard.string(forKey: "nickname") ?? "")님\n현재까지 ") + Text("\(viewModel.mainHistory.reduce(0){$0 + $1.1})").foregroundColor(.mainColor)
            + Text("번 목표에 다가가셨어요!\n앞으로 더 기대 되는걸요:)"))
            .multilineTextAlignment(.leading)
            .font(.system(size: 22,weight: .bold))
            .background(Color.white.edgesIgnoringSafeArea(.horizontal))
            .padding([.horizontal,.bottom],20)
            
            ZStack{
                Color.gray10.ignoresSafeArea()
                VStack{
                    LazyVGrid(columns:[GridItem(.flexible()),GridItem(.flexible())], spacing: 15){
                        ForEach(HistoryType.allCases, id:\.rawValue){
                            HistoryContentView(type:$0, amount: viewModel.getMainHistoryAmount(type: $0))
                        }
                    }
                    Spacer()
                }.padding(.top, 30)
                .padding(.horizontal, 20)
            }
        }
        .onAppear{
            viewModel.fetchMainHistory()
        }
    }
}

struct HistoryHomeView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryHomeView()
    }
}
