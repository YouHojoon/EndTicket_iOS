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
    private let maxTextLength: Int
    
    @State private var shouldShowRedBounds = false
    @Binding private var text:String
    @FocusState private var focus
    
    init(title:String, placeholder:String, text:Binding<String>, maxTextLength: Int = 20){
        self.title = title
        self.placeholder = placeholder
        self.maxTextLength = maxTextLength
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
            .overlay{
                RoundedRectangle(cornerRadius: 10)
                    .stroke(shouldShowRedBounds ? .red : .clear, lineWidth: 1)
            }
            .background{
                Color.white.onTapGesture {
                    focus = true
                }
            }
            .cornerRadius(10)
            .onChange(of: text){
                if $0.count > maxTextLength{
                    text = String($0.prefix(maxTextLength))
                    shouldShowRedBounds = true
                    print(shouldShowRedBounds)
                }
                if $0.count < maxTextLength{
                    shouldShowRedBounds = false
                }
            }
        }
    }
}

struct TicketFormTextField_Previews: PreviewProvider {
    static var previews: some View {
        TicketFormView()
    }
}
