//
//  EndTicketAler.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/12.
//

import Foundation
import SwiftUI
protocol EndTicketAlert:View{
    associatedtype Content: View
    var content: Content {get}
    var primaryButton: EndTicketAlertButton {get}
    var secondaryButton: EndTicketAlertButton? {get}
    
    init(content: () -> Content, primaryButton: () ->  EndTicketAlertButton, secondaryButton: (() -> EndTicketAlertButton)?)
}
