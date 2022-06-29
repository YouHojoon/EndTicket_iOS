//
//  EndTicketAlert.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/27.
//

import SwiftUI

struct EndTicketAlert<Content>: View where Content: View{
    let content: Content
    let primaryButton: EndTicketAlertButton
    let secondButton: EndTicketAlertButton?
    
    
    //    @State private var alertFrame:CGRect = .zero
    init(content: () -> Content, primaryButton: () ->  EndTicketAlertButton, secondButton: (() -> EndTicketAlertButton)? = nil){
        self.content = content()
        self.primaryButton = primaryButton()
        self.secondButton = secondButton?()
    }
    
    var body: some View {
        ZStack{
            Color.black.opacity(0.3).ignoresSafeArea()
     
            content
                .padding(.bottom, 60)
                .frame(maxWidth:315, minHeight: 169)
                .overlay(
                    VStack(spacing:0){
                        Divider()
                        HStack(){
                            primaryButton
                            if secondButton != nil{
                                Divider()
                                secondButton
                            }
                        }
                        .frame(height:60)
                        .font(.system(size: 16,weight: .bold))
                    }
                    , alignment: .bottom)
                .background(
                    Color.white
                ).cornerRadius(10)
        }
    }
}

//struct EndTicketAlert_Previews: PreviewProvider {
//    static var previews: some View {
//        EndTicketAlert(title: "변경된 내용은 저장되지 않습니다.\n이 화면을 나가시겠습니까?"){
//            EndTicketAlertButton(title:Text("예").foregroundColor(.gray600)){
//                
//            }
//        }secondButton: {
//            EndTicketAlertButton(title:Text("아니요").foregroundColor(.red)){
//                
//            }
//        }
//    }
//}
