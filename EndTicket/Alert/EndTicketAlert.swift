//
//  EndTicketAlert.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/27.
//

import SwiftUI

struct EndTicketAlert: View{
    let title: String
    let primaryButton: EndTicketAlertButton
    let secondButton: EndTicketAlertButton
    init(title: String, primaryButton: () ->  EndTicketAlertButton, secondButton: () -> EndTicketAlertButton){
        self.title = title
        self.primaryButton = primaryButton()
        self.secondButton = secondButton()
    }
    var body: some View {
        ZStack{
            Color.black.opacity(0.3).ignoresSafeArea()
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .frame(width:315,height: 169)
                .overlay{
                    VStack(spacing:0){
                        Spacer()
                        Text(title).font(.system(size: 18,weight: .bold))
                            .multilineTextAlignment(.center)
                        Spacer()
                        Divider()
                        HStack{
                            primaryButton
                            Divider()
                            secondButton
                        }
                        .font(.system(size: 16,weight: .bold))
                        .frame(height:60)
                    }
                }
        }
    }
}

struct EndTicketAlert_Previews: PreviewProvider {
    static var previews: some View {
        EndTicketAlert(title: "변경된 내용은 저장되지 않습니다.\n이 화면을 나가시겠습니까?"){
            EndTicketAlertButton(title:Text("예").foregroundColor(.gray600)){
                
            }
        }secondButton: {
            EndTicketAlertButton(title:Text("아니요").foregroundColor(.red)){
                
            }
        }
    }
}
