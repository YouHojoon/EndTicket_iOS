//
//  ImagineView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/09.
//

import SwiftUI

struct ImagineView: View {
    @EnvironmentObject private var viewModel: ImagineViewModel
    
    private let index: Int
    private let uncompletedButtonColor = Color(#colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1))
    private let completeButtonColor = Color(#colorLiteral(red: 0.2705882353, green: 0.337254902, blue: 1, alpha: 1))
    init(_ index: Int){
        self.index = index
    }
    
    var body: some View {
        let isCompleted = viewModel.imagines[index].isCompleted
        HStack(spacing:15){
            Button{
                viewModel.toggleIsCompleted(index: index)
            }label:{
                Circle()
                    .frame(width:34, height: 34)
                    .foregroundColor(isCompleted ? completeButtonColor : .clear)
                    .overlay{
                        if !isCompleted{
                            Circle().stroke(completeButtonColor, lineWidth: 2)
                        }
                    }
                    .overlay{
                        Image(systemName: "checkmark")
                            .foregroundColor(isCompleted ? .white : completeButtonColor)
                    }
            }
            
            VStack(alignment: .leading, spacing:3){
                Text(viewModel.imagines[index].goal).font(.gmarketSansMeidum(size: 16))
                    .strikethrough(isCompleted)
                    .frame(height:20)
                Text(viewModel.imagines[index].desciption)
                    .font(.gmarketSansMeidum(size: 12))
                    .strikethrough(isCompleted)
                    .foregroundColor(Color(#colorLiteral(red: 0.404, green: 0.404, blue: 0.404, alpha: 1)))
                    .frame(height:20)
            }
            Spacer()
        }
        .frame(height:43)
    }
}


