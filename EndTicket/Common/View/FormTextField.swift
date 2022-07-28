//
//  SwiftUIView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/17.
//

import SwiftUI

struct FormTextField: View {
    private let title:String?
    private let placeholder: String?
    private let maxTextLength: Int
    private let titleImage: Image?
    private let isEssential:Bool
    private let borderColor: Color
    private let height: CGFloat
    
    @State private var shouldShowRedBounds = false
    @Binding private var text:String
    @FocusState private var focus
    
    init(title:String? = nil,titleImage:Image? = nil, placeholder:String? = nil, text:Binding<String>,
         height: CGFloat = 50, maxTextLength: Int = 20, isEssential:Bool = false, borderColor: Color = .clear){
        self.title = title
        self.titleImage = titleImage
        self.placeholder = placeholder
        self.maxTextLength = maxTextLength
        self.isEssential = isEssential
        self.borderColor = borderColor
        self.height = height
        _text = text
    }
    
    
    var body: some View {
        VStack(alignment:.leading, spacing:0){
            HStack(spacing:0){
                if let titleImage = self.titleImage {
                    titleImage
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:15,height: 15)
                        .foregroundColor(.black)
                        .padding(.trailing,5)
                }
                if let title = self.title{
                    HStack(alignment:.top,spacing:2){
                        Text(title)
                            .font(.interBold(size: 16))
                            .padding(.trailing,1)
                         if isEssential{
                             Image("essential_mark")
                                 .padding(.top,2)
                         }
                    }
                }
            }
            .padding(.bottom, title != nil || titleImage != nil ? 8 : 0)
            
            TextField(placeholder ?? "", text: $text, onCommit: {
                focus = false
            })
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .font(.interBold(size: 14))
            .focused($focus)
            .padding()
            .frame(height:height)
            .overlay{
                RoundedRectangle(cornerRadius: 10)
                    .stroke(shouldShowRedBounds ? .red : borderColor, lineWidth: 1)
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
        TicketFormView().environmentObject(TicketViewModel())
    }
}
