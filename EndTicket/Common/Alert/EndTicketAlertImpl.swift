//
//  EndTicketAlert.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/27.
//

import SwiftUI

struct EndTicketAlertImpl<Content>:EndTicketAlert where Content:View{
    let content: Content
    let primaryButton: EndTicketAlertButton
    let secondaryButton: EndTicketAlertButton?
    
    init(content: () -> Content, primaryButton: () ->  EndTicketAlertButton, secondaryButton: (() -> EndTicketAlertButton)? = nil){
        self.content = content()
        self.primaryButton = primaryButton()
        self.secondaryButton = secondaryButton?()
    }

    var body: some View {
        ZStack{
            Color.black.opacity(0.3).ignoresSafeArea()
            
            content
                .padding(.bottom, 60)
                .frame(maxWidth:UIScreen.main.bounds.width - 40,minHeight: 169)
                .overlay(
                    VStack(spacing:0){
                        if primaryButton.color == nil{
                            Divider()
                        }
                        
                        HStack(){
                            primaryButton
                            if secondaryButton != nil{
                                Divider()
                                secondaryButton
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
