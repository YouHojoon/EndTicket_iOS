//
//  LoginView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/05/27.
//

import SwiftUI

struct LoginView: View {
    @AppStorage("isFirstStart") private var isFirstStart:Bool = true
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .frame(maxWidth:.infinity, maxHeight: .infinity)
            .overlay(isFirstStart ? OnBoarding.home.view.transition(.opacity) : nil)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
