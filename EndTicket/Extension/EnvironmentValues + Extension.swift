//
//  EnvironmentValues + Extension.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/17.
//

import Foundation
import SwiftUI
extension EnvironmentValues{
    var fullScreenDismiss: Binding<Bool>{
        set{
            self[FullScreenDismissKey.self] = newValue
        }
        get{
            self[FullScreenDismissKey.self]
        }
    }
}

fileprivate struct FullScreenDismissKey: EnvironmentKey {
    static let defaultValue = Binding<Bool>.constant(false)
}
