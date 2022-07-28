//
//  ImagineFormView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/03.
//

import Foundation
import SwiftUI
struct ImagineFormView: View{
    private let type: `Type`
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
        type = .add
    }
    init(_ imagine: Imagine){
        _subject = State(initialValue: imagine.subject)
        _purpose = State(initialValue: imagine.purpose)
        _color = State(initialValue: imagine.color)
        imagineId = imagine.id
        type = .modify
        _isEnabledButton = State(initialValue: true)
    }
    
    var body: some View{
        VStack(spacing:0){
            HStack(spacing:0){
                Image("arrow_left")
                    .font(.system(size:15, weight: .medium))
                    .frame(width: 40, height: 40)
                    .contentShape(Rectangle())
                    .padding(.leading, 10)
                    .onTapGesture {
                        shouldShowAlert = true
                    }
                Spacer()
                Text("상상하기")
                    .font(.system(size: 21,weight: .bold))
                Spacer()
                
                addOrModifyButton
                    .disabled(!isEnabledButton)
                    .frame(width:40,height: 40)
                    .foregroundColor(isEnabledButton ? .black : .gray600)
                    .padding(.trailing, 18)
                    
            }
            .padding(.vertical,13)
            .background(Color.white)
            
            ScrollView(showsIndicators:false){
                VStack(alignment:.leading,spacing: 20){
                    FormTextField(title:"제목",titleImage: Image("arrow_right"), placeholder: "목표를 간단하게 적어보세요",text: $subject, maxTextLength: 10,isEssential: imagineId == nil)
                    FormTextField(title:"목표",titleImage: Image("goal_icon"), placeholder: "달성하고 나면, 나의 모습은 어떨까요?",text: $purpose, maxTextLength: 20,isEssential: imagineId == nil)
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
                            .cornerRadius(10)
                    }
                    
                }.padding(.top, 30)
            }
            .padding(.horizontal, 20)
            Spacer()
        }
      
        .background(Color.gray50.ignoresSafeArea())
        
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
        }
        .returnAlert(isPresented: $shouldShowAlert, dismiss: dismiss)
        //MARK: - 삭제 alert
        .alert(isPresented: $shouldShowDeleteAlert){
            EndTicketAlertImpl{
                Text("상상하기를 삭제하시겠습니까?")
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
        switch type {
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
    
    private enum  `Type` {
        case add, modify
    }
    
}

struct ImagineFormView_Previews: PreviewProvider{
    static var previews: some View{
        ImagineFormView()
    }
}
