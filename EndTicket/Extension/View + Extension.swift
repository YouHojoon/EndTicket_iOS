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
    
    func alert<Alert>(isPresented:Binding<Bool>, alert: () -> Alert) -> some View where Alert: EndTicketAlert {
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
    func progressView(isPresented:Binding<Bool>) -> some View{
        var keyWindow = UIApplication.shared.connectedScenes.filter ({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene}).compactMap {$0}.first?.windows.filter { $0.isKeyWindow }.first!
        if keyWindow == nil {
            let scence = UIApplication.shared.connectedScenes.map({$0 as? UIWindowScene}).first!
            keyWindow = scence?.keyWindow
        }
        let view = ZStack{
            Color.black.opacity(0.3)
            ProgressView().progressViewStyle(.circular).tint(.white)
        }.ignoresSafeArea()
        
        let vc = UIHostingController(rootView:view)
        vc.modalPresentationStyle = .overCurrentContext
        vc.view.backgroundColor = .clear
        vc.definesPresentationContext = true
        
        return self.onChange(of: isPresented.wrappedValue, perform: {
            if $0{
                keyWindow?.rootViewController?.topViewController().present(vc,animated: false)
            }
            else{
                keyWindow?.rootViewController?.topViewController().dismiss(animated: false)
            }
        })
    }
    
    
    func maxContentAlert(isPresented:Binding<Bool>) -> some View{
        return alert(isPresented: isPresented){
            EndTicketAlertImpl{
                VStack(spacing:20){
                    Text("현재 목표에 집중해주세요!")
                        .font(.system(size: 18, weight: .bold))
                        .multilineTextAlignment(.center)
                        .lineSpacing(0.83)
                    Text("새로 추가하고 싶다면\n하나를 삭제하고 추가해주세요:)")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.gray300)
                        .multilineTextAlignment(.center)
                }.foregroundColor(Color.black)
                    .padding(.top, 40)
                    .padding(.bottom, 30)
            }primaryButton: {
                EndTicketAlertButton(label:Text("확인").font(.system(size: 16,weight: .bold)).foregroundColor(.mainColor)){
                    isPresented.wrappedValue = false
                }
            }
        }
    }
    
    func returnAlert(isPresented:Binding<Bool>, dismiss: DismissAction) -> some View{
        return alert(isPresented: isPresented){
            EndTicketAlertImpl{
                Text("변경된 내용은 저장되지 않습니다.\n이 화면을 나가시겠습니까?").font(.system(size: 18,weight: .bold))
                    .multilineTextAlignment(.center)
            } primaryButton:{
                EndTicketAlertButton(label:Text("취소").foregroundColor(.gray600)){
                    isPresented.wrappedValue = false
                }
            }secondaryButton: {
                EndTicketAlertButton(label:Text("나가기").foregroundColor(.red)){
                    isPresented.wrappedValue = false
                    dismiss()
                }
            }
        }
    }
    
}


