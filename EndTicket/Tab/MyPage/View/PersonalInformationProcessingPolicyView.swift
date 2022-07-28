//
//  a.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/14.
//

import Foundation
import SwiftUI
struct PersonalInformationProcessingPolicyView: View{
    @Environment(\.dismiss) private var dismiss
    
    var body: some View{
        VStack{
            Group{
                HStack{
                    Image(systemName: "arrow.backward")
                        .font(.system(size:15, weight: .medium))
                        .padding(.trailing,13)
                        .onTapGesture {
                            dismiss()
                        }
                    Spacer()
                    Text("개인정보처리방침")
                        .font(.system(size: 21,weight: .bold))
                        .offset(x:-20)
                    Spacer()
                }.padding(.top, 23.67)
                
            }.padding(.leading,20)
            
            PDFRepresentable(url: Bundle.main.url(forResource: "개인정보처리방침", withExtension: ".pdf")!)
        }
    }
}
