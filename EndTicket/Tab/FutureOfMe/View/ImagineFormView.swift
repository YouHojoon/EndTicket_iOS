//
//  ImagineFormView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/03.
//

import Foundation
import SwiftUI
struct ImagineFormView: View{
    private let buttonType:ButtonType
    private let imagineId: Int?
    @State private var subject = ""
    @State private var purpose = ""
    @State private var color: Color = .ticketRed1
    
    @State private var shouldShowAlert = false
    @State private var shouldShowDeleteAlert = false
    @State private var isEnabledButton = false
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var viewModel: FutureOfMeViewModel
    
    
    init(){
        imagineId = nil
        buttonType = .add
    }
    init(_ imagine: Imagine){
        _subject = State(initialValue: imagine.subject)
        _purpose = State(initialValue: imagine.purpose)
        _color = State(initialValue: imagine.color)
        imagineId = imagine.id
        buttonType = .modify
    }
    
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
                    FormTextField(title:"제목",titleImage: Image(systemName: "arrow.right.circle"), placeholder: "시작역-목표를 이루려면 어떤 행동을 해야 할까요?",text: $subject, isEssential: imagineId == nil)
                    FormTextField(title:"목표",titleImage: Image("futureOfMe_description_icon"), placeholder: "종착역-달성하고 나면, 나의 모습은 어떨까요?",text: $purpose, isEssential: imagineId == nil)
                    Divider().padding(.vertical, 10)
                    ColorSelectView(selected: $color)
                        .padding(.bottom, 40)
                    if imagineId != nil{
                        Button{
                            shouldShowDeleteAlert = true
                        }label: {
                            Text("삭제하기")
                                .font(.interSemiBold(size: 14))
                                .foregroundColor(Color( #colorLiteral(red: 0.9623875022, green: 0.3615829945, blue: 0.2794611752, alpha: 1)))
                                .frame(maxWidth:.infinity, minHeight: 50, maxHeight: 50)
                        }.background(Color.white)
                    }
                    
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
        .onChange(of: !subject.isEmpty && !purpose.isEmpty){
            isEnabledButton = $0
        }
        .onReceive(viewModel.isSuccessPostImagine){
            if $0{
                dismiss()
            }
        }
        .onReceive(viewModel.isSuccessModifyImagine){
            if $0{
                dismiss()
            }
        }
        .onReceive(viewModel.isSuccessDeleteImagine){
            if $0{
                dismiss()
            }
        }//MARK: - 삭제 alert
        .alert(isPresented: $shouldShowDeleteAlert){
            EndTicketAlert{
                Text("티켓을 삭제하시겠습니까?")
                    .font(.system(size:18,weight:.bold))
            }primaryButton: {
                EndTicketAlertButton(label:Text("취소").foregroundColor(.gray400)){
                    shouldShowDeleteAlert = false
                }
            }secondaryButton: {
                EndTicketAlertButton(label:Text("삭제").foregroundColor(.red)){
                    viewModel.deleteImagine(id: imagineId!)
                    shouldShowDeleteAlert = false
                    dismiss()
                }
            }
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
                    viewModel.postImagine(Imagine(subject: subject, purpose: purpose, color: color))
                }
                
        case .modify:
            Text("수정")
                .font(.interMedium(size: 13))
                .underline()
                .onTapGesture{
                    viewModel.modifyImagine(Imagine(subject: subject, purpose: purpose, color: color, id: imagineId!))
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
