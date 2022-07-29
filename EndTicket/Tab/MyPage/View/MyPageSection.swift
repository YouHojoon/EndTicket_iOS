//
//  MyPageButton.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/14.
//

import Foundation
import SwiftUI
struct MyPageSection: View{
    private let title:String
    init(title:String){
        self.title = title
    }
    
    var body: some View{
        VStack(spacing:0){
            HStack{
                Text("\(title)")
                    .font(.system(size: 16,weight: .medium))
                Spacer()
                Image(systemName:"chevron.forward")
                    .foregroundColor(.gray300)
                    .font(.system(size: 10.5))
            }.foregroundColor(.black)
            .padding(.vertical,20)
            .contentShape(Rectangle())
            Divider()
        }
    }
}
