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
    
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func alert<Content>(isPresented:Binding<Bool>, alert: () -> EndTicketAlert<Content>) -> some View where Content: View{
        let keyWindow = UIApplication.shared.connectedScenes.filter ({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene}).compactMap {$0}.first?.windows.filter { $0.isKeyWindow }.first!

        let vc = UIHostingController(rootView: alert())
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        vc.view.backgroundColor = .clear
        vc.definesPresentationContext = true
        
        return self.onChange(of: isPresented.wrappedValue, perform: {
            if $0{
                keyWindow?.rootViewController?.topViewController().present(vc,animated: true)
            }
            else{
                keyWindow?.rootViewController?.topViewController().dismiss(animated: true)
            }
        })
    }
}
