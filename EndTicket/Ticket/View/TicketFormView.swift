//
//  AddTicketView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/17.
//

import SwiftUI

struct TicketFormView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var viewModel: TicketViewModel
    
    @State private var title: String = ""
    @State private var start: String = ""
    @State private var end: String = ""
    @State private var category: Ticket.Category = .allCases[0]
    @State private var color: Color = .ticketRed1
    @State private var touchCount: Int = 5
    @State private var shouldShowAlert = false
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
        _title = State(initialValue: ticket.title)
        _start = State(initialValue: ticket.start)
        _end = State(initialValue: ticket.end)
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
            }.padding(.horizontal, 20)
                .padding(.vertical,18)
                .background(Color.white)
            
            ScrollView(showsIndicators:false){
                VStack(alignment:.leading,spacing: 20){
                    TicketFormTextField(title:"제목", placeholder: "목표를 간단하게 적어보세요.",text: $title)
                    TicketFormTextField(title:"시작역", placeholder: "목표를 이루려면 어떻게 해야 활까요?",text: $start)
                    TicketFormTextField(title:"종착역", placeholder: "달성하고 나면, 나의 모습은 어떨까요?",text: $end)
                    Divider().padding(.vertical, 10)
                    TicketFormCategoryView(selected: $category)
                    TicketColorSelectView(selected: $color)
                    TicketTouchCountSelectView(selected: $touchCount)
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
        }.alert(isPresented: $shouldShowAlert){
           alert
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
                    viewModel.postTicket(Ticket(title: title, category: category, start: start, end: end, color: color, touchCount: touchCount))
                }
                .onReceive(viewModel.isPostTicketSuccess){result in
                    withAnimation{
                        dismiss()
                    }
                }
        case .modify:
            Text("수정")
                .font(.interMedium(size: 13))
                .underline()
                .onTapGesture{
                    viewModel.modifyTicket(Ticket(title: title, category: category, start: start, end: end, color: color, touchCount: touchCount, id:ticketId!))
                }
                .onReceive(viewModel.isModifyTicketSuccess){result in
                    withAnimation{
                        dismiss()
                    }
                }
        }
    }
    
    var alert: EndTicketAlert{
        switch buttonType{
        case .add:
            return EndTicketAlert(title:"변경된 내용은 저장되지 않습니다.\n이 화면을 나가시겠습니까?"){
                EndTicketAlertButton(title:Text("예").foregroundColor(.gray600)){
                    shouldShowAlert = false
                    dismiss()
                }
            }secondButton: {
                EndTicketAlertButton(title:Text("아니요").foregroundColor(.black)){
                    shouldShowAlert = false
                }
            }
        case .modify:
            return EndTicketAlert(title:"변경된 내용은 저장되지 않습니다.\n이 화면을 나가시겠습니까?"){
                EndTicketAlertButton(title:Text("예").foregroundColor(.gray600)){
                    shouldShowAlert = false
                    dismiss()
                }
            }secondButton: {
                EndTicketAlertButton(title:Text("아니요").foregroundColor(.black)){
                    shouldShowAlert = false
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
