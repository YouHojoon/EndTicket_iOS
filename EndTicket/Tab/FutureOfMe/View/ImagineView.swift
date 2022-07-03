//
//  ImagineView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/09.
//

import SwiftUI

struct ImagineView: View {
    private let index: Int
    private let uncompletedButtonColor = Color(#colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1))
    private let completeButtonColor = Color(#colorLiteral(red: 0.2705882353, green: 0.337254902, blue: 1, alpha: 1))
    
    @State private var shouldShowModifyView = false
    @EnvironmentObject private var viewModel: ImagineViewModel
    
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
            }.padding(.horizontal,1)
            
            VStack(alignment: .leading, spacing:3){
                Text(viewModel.imagines[index].goal).font(.system(size:16,weight: .bold))
                    .strikethrough(isCompleted)
                    .frame(height:20)
                    .foregroundColor(isCompleted ? .gray300 : .black)
                
                HStack(spacing:3){
                    Image("futureOfMe_description_icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:15,height: 15)
                    
                    Text(viewModel.imagines[index].desciption)
                        .font(.system(size: 12,weight: .regular))
                        .strikethrough(isCompleted)
                }
                .frame(height:20)
                .foregroundColor(isCompleted ? .gray300 : .gray500)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray300)
                .font(.system(size: 10.5))
                .contentShape(Rectangle())
                .frame(width:20,height: 20)
                .onTapGesture {
                    withAnimation{
                        shouldShowModifyView = true
                    }
                }
        }
        .frame(height:43)
        .fullScreenCover(isPresented:$shouldShowModifyView){
            ImagineFormView()
        }
    }
}

struct ImagineView_Previews: PreviewProvider {
    static var previews: some View {
        FutureOfMeView_Previews.previews
    }
}

