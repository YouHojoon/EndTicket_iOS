//
//  LoginButtonModifier.swift
//  EndTicket
//
//  Created by 유호준 on 2022/05/27.
//

import Foundation
import SwiftUI

//MARK: - 로그인 버튼 공통 속성
struct LoginButtonModifier: ViewModifier{
    let color: Color
    
    init(_ color: Color = .white){
        self.color = color
    }
    
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(.black)
            .frame(maxWidth:335, maxHeight: 50)
            .background(color)
            .cornerRadius(10)
    }
}
