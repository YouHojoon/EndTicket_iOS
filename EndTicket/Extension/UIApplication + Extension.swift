//
//  UIApplication + Extension.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/15.
//

import Foundation
import UIKit
extension UIApplication{
    var keyWindow: UIWindow?{
        return UIApplication.shared.connectedScenes.filter ({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene}).compactMap {$0}.first?.windows.filter { $0.isKeyWindow }.first ??  UIApplication.shared.connectedScenes.compactMap{$0 as? UIWindowScene}.first?.keyWindow
       
    }
}
