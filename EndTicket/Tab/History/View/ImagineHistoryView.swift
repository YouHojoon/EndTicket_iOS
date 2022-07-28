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
    @State private var isNotScolled = true
    var body: some View {
        VStack(alignment:.leading, spacing:0){
            HistoryType.imagine.headContent(dismiss: dismiss, isNotScrolled: $isNotScolled)
            HistoryType.imagine.mainContent(isNotScrolled:$isNotScolled){
                ForEach(viewModel.imagineHistories,id:\.id){
                    ImagineViewForHistory($0)
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
