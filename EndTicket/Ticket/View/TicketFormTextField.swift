//
//  SwiftUIView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/17.
//

import SwiftUI

struct TicketFormTextField: View {
    private let title:String
    private let placeholder: String
    
    @Binding private var text:String
    @FocusState private var focus
    
    init(title:String, placeholder:String, text:Binding<String>){
        self.title = title
        self.placeholder = placeholder
        _text = text
    }
    
    
    var body: some View {
        VStack(alignment:.leading, spacing:0){
            Text(title)
                .font(.interSemiBold(size: 16))
                .padding(.bottom, 4)
            TextField(placeholder, text: $text, onCommit: {
                focus = false
            })
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .font(.interSemiBold(size: 14))
            .focused($focus)
            .padding()
            .frame(height:50)
            .background(Color.white.onTapGesture {
                focus = true
            })
            .cornerRadius(10)
        }
    }
}

struct TicketFormTextField_Previews: PreviewProvider {
    static var previews: some View {
        TicketFormView()
    }
}
