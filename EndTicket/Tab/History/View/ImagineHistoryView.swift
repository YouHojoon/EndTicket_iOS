//
//  ImagineHistoryView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/13.
//

import SwiftUI

struct ImagineHistoryView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var viewModel: HistoryViewModel
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
                        Text("상상하기")
                            .font(.system(size: 21,weight: .bold))
                        Spacer()
                    }.padding(.top, 23.67)
                        .padding(.bottom, 43)
                    
                    Text("상상한 것보다!\n더 잘 됐을 거에요:)")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 22,weight: .bold))
                    .padding(.bottom,20)
                }.padding(.horizontal,20)
            }
            .background(Color.white.edgesIgnoringSafeArea(.horizontal))

            ZStack{
                Color.gray10.ignoresSafeArea()
                ScrollView{
                    LazyVStack(spacing:20){
                        ForEach(viewModel.imagineHistories,id:\.id){
                            ImagineViewForHistory($0)
                        }
                        Spacer()
                    }.padding(.top, 30)
                        .padding(.horizontal, 20)
                }
            }
        }.onAppear{
            viewModel.fetchImagineHistory()
        }
    }
}

struct ImagineHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        ImagineHistoryView()
    }
}
