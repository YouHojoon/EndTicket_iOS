//
//  View + Extension.swift
//  EndTicket
//
//  Created by 유호준 on 2022/05/27.
//

import Foundation
import SwiftUI
extension View{
    func eraseToAnyView() -> AnyView{
        return AnyView(self)
    }
    
    func listenKeyBoardShowAndHide(_ isKeyboardShow:Binding<Bool>) -> some View{
        return self.onReceive(NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillShowNotification)){_ in
            isKeyboardShow.wrappedValue = true
        }.onReceive(NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillHideNotification)){_ in
            isKeyboardShow.wrappedValue = false
        }
    }
}
