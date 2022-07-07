//
//  EndTicketAlertButton.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/27.
//

import SwiftUI

struct EndTicketAlertButton: View {
    typealias Action = () -> ()
    
    private let action: Action
    private let label: Text
    let color: Color?
    
    init(label:Text,color:Color? = nil,action: @escaping Action){
        self.label = label
        self.action = action
        self.color = color
    }
    
    var body: some View {
        Button{
            action()
        }label: {
            label.frame(maxWidth:.infinity, maxHeight: .infinity)
        }.background(color)
    }
}
//
//struct EndTicketAlertButton_Previews: PreviewProvider {
//    static var previews: some View {
//        EndTicketAlertButton()
//    }
//}
