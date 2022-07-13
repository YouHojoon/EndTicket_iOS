//
//  MissionHistoryView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/13.
//

import SwiftUI

struct MissionHistoryView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var viewModel: HistoryViewModel
    
    var body: some View {
        VStack(alignment:.leading, spacing:0){
            HistoryType.mission.headContent(dismiss: dismiss)
            HistoryType.mission.mainContent{
                ForEach(viewModel.missionHistories,id:\.id){mission in
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height:70)
                        .foregroundColor(.white)
                        .shadow(color: Color(hex:"#7090B0").opacity(0.15), radius: 20, x: 0, y: 5)
                        .overlay{
                            VStack(alignment:.leading,spacing: 5){
                                HStack(spacing:5.5){
                                    Image(systemName: "clock")
                                        .font(.system(size: 13))
                                        .foregroundColor(.mainColor)
                                    
                                    Text("02:00:12")
                                        .font(.interSemiBold(size: 12))
                                        .foregroundColor(.mainColor)
                                }
                                HStack{
                                    Text("\(mission.mission)")
                                        .font(.interSemiBold(size: 14))
                                        .foregroundColor(.black)
                                    Spacer()
                                    Text("\(mission.updatedAt!)")
                                        .font(.interSemiBold(size: 12))
                                        .foregroundColor(.gray500)
                                }
                            }.padding(.horizontal,20)
                        }
                    
                }
            }
        }.onAppear{
            viewModel.fetchMissionHistory()
        }
    }
}

struct MissionHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        MissionHistoryView()
    }
}
