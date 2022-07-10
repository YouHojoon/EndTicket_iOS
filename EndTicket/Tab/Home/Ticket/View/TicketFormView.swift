//
//  AddTicketView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/17.
//

import SwiftUI
import Combine

struct TicketFormView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var viewModel: TicketViewModel
    
    @State private var subject: String = ""
    @State private var purpose: String = ""
    @State private var category: Ticket.Category = .allCases[0]
    @State private var color: Color = .ticketRed1
    @State private var touchCount: Int = 5
    @State private var shouldShowAlert = false
    @State private var isEnabledButton = false
    @State private var shouldShowDeleteAlert = false
    private let buttonType:ButtonType
    private let ticketId: Int?
    
    init(){
        buttonType = .add
        ticketId = nil
    }
    
    //MARK: - 수정을 위한 생성자
    init(_ ticket: Ticket){
        ticketId = ticket.id
        buttonType = .modify
        _subject = State(initialValue: ticket.subject)
        _purpose = State(initialValue: ticket.purpose)
        _category = State(initialValue: ticket.category)
        _color = State(initialValue: ticket.color)
        _touchCount = State(initialValue: ticket.touchCount)
    }
    
    var body: some View {
        VStack(spacing:0){
            HStack(spacing:0){
                Image(systemName: "arrow.backward")
                    .font(.system(size:15, weight: .medium))
                    .padding(.trailing,13)
                    .onTapGesture {
                        shouldShowAlert = true
                    }
                Text(ticketId == nil ? "티켓 추가하기" : "티켓 수정하기")
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
                    FormTextField(title:"행동", titleImage: Image(systemName: "arrow.right.circle"),placeholder: "어떤 행동을 해야 목표를 이룰 수 있을 까요?",text: $subject, isEssential: ticketId == nil)
                    FormTextField(title:"목표", titleImage: Image("futureOfMe_description_icon"),placeholder: "달성하게 되면 나의 모습은 어떨까요?",text: $purpose, isEssential: ticketId == nil)
                    Divider().padding(.vertical, 10)
                    TicketFormCategoryView(selected: $category,isEssential: ticketId == nil)
                    ColorSelectView(selected: $color)
                    TicketTouchCountSelectView(selected: $touchCount,isEssential: ticketId == nil)
                        .padding(.bottom, 40)
                    if ticketId != nil{
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
        .onAppear{
            UIScrollView.appearance().bounces = false
        }.onDisappear{
            UIScrollView.appearance().bounces = true
        }
        .onTapGesture {
            hideKeyboard()
        }
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
        .onReceive(viewModel.isSuccessDeleteTicket){_, result in
            if result{
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
                    viewModel.deleteTicket(id: ticketId!)
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
                    viewModel.postTicket(Ticket(category: category, subject: subject, purpose: purpose, color: color, touchCount: touchCount))
                }
                .onReceive(viewModel.isSuccessPostTicket){result in
                    withAnimation{
                        dismiss()
                    }
                }
        case .modify:
            Text("수정")
                .font(.interMedium(size: 13))
                .underline()
                .onTapGesture{
                    viewModel.modifyTicket(Ticket(category: category, subject: subject, purpose: purpose, color: color, touchCount: touchCount, id:ticketId!))
                }
                .onReceive(viewModel.isSuccessModifyTicket){result in
                    withAnimation{
                        dismiss()
                    }
                }
        }
    }
    
    private enum  ButtonType {
        case add, modify
    }
}

//struct TicketFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        TicketFormView()
//    }
//}
