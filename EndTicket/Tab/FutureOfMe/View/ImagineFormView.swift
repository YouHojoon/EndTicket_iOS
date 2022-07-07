//
//  ImagineFormView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/03.
//

import Foundation
import SwiftUI
struct ImagineFormView: View{
    private var buttonType:ButtonType = .add
    
    @State private var behavior = ""
    @State private var goal = ""
    @State private var color: Color = .ticketRed1
    
    @State private var shouldShowAlert = false
    @State private var isEnabledButton = false
    
    @Environment(\.dismiss) private var dismiss
   
    var body: some View{
        VStack(spacing:0){
            HStack(spacing:0){
                Image(systemName: "arrow.backward")
                    .font(.system(size:15, weight: .medium))
                    .padding(.trailing,13)
                    .onTapGesture {
                        shouldShowAlert = true
                    }
                Text("상상해보기")
                    .font(.interSemiBold(size: 20))
                Spacer()
                addOrModifyButton
                    .disabled(!isEnabledButton)
                    .foregroundColor(isEnabledButton ? .black : .gray600)
                    
            }.padding(.horizontal, 20)
                .padding(.vertical,18)
                .background(Color.white)
            
            ScrollView(showsIndicators:false){
                VStack(alignment:.leading,spacing: 20){
                    FormTextField(title:"제목",titleImage: Image(systemName: "arrow.right.circle"), placeholder: "시작역-목표를 이루려면 어떤 행동을 해야 할까요?",text: $behavior)
                    FormTextField(title:"목표",titleImage: Image("futureOfMe_description_icon"), placeholder: "종착역-달성하고 나면, 나의 모습은 어떨까요?",text: $goal)
                    Divider().padding(.vertical, 10)
                    ColorSelectView(selected: $color)
                }.padding(.top, 30)
            }
            .padding(.horizontal, 20)
            Spacer()
        }
      
        .background(Color.gray50.ignoresSafeArea())
        .alert(isPresented: $shouldShowAlert){
            EndTicketAlert{
                Text("변경된 내용은 저장되지 않습니다.\n이 화면을 나가시겠습니까?").font(.system(size: 18,weight: .bold))
                    .multilineTextAlignment(.center)
            } primaryButton:{
                EndTicketAlertButton(label:Text("취소").foregroundColor(.gray600)){
                    shouldShowAlert = false
                }
            }secondaryButton: {
                EndTicketAlertButton(label:Text("나가기").foregroundColor(.red)){
                    shouldShowAlert = false
                    dismiss()
                }
            }
        }
        .onChange(of: !behavior.isEmpty && !goal.isEmpty){
            isEnabledButton = $0
        }
        
        
    }
    
    
    @ViewBuilder
    var addOrModifyButton: some View{
        switch buttonType {
        case .add:
            Text("등록")
                .font(.interMedium(size: 13))
                .underline()
                .onTapGesture {
                    
                }
                
        case .modify:
            Text("수정")
                .font(.interMedium(size: 13))
                .underline()
                .onTapGesture{
                   
                }
                
        }
    }
    
    private enum  ButtonType {
        case add, modify
    }
    
}

struct ImagineFormView_Previews: PreviewProvider{
    static var previews: some View{
        ImagineFormView()
    }
}
