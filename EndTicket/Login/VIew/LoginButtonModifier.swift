//
//  LoginButtonModifier.swift
//  EndTicket
//
//  Created by 유호준 on 2022/05/27.
//

import Foundation
import SwiftUI

struct LoginButtonModifier: ViewModifier{
    let color: Color
    
    init(_ color: Color = .white){
        self.color = color
    }
    
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(.black)
            .frame(maxWidth:328, maxHeight: 56)
            .background(color)
            .cornerRadius(12)
    }
}
