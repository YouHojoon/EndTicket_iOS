//
//  OnBoardingButtonModifier.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/03.
//

import Foundation
import SwiftUI
struct OnBoardingButtonModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .background(Color.gray)
            .cornerRadius(8)
    }
}
