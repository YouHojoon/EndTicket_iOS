//
//  EndTicketAlertButton.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/27.
//

import SwiftUI

struct EndTicketAlertButton: View {
    typealias Action = () -> ()
    
    let action: Action
    let title: Text
    
    init(title:Text, action: @escaping Action){
        self.title = title
        self.action = action
    }
    
    var body: some View {
        Button{
            action()
        }label: {
            title.frame(maxWidth:.infinity, maxHeight: .infinity)
        }
    }
}
//
//struct EndTicketAlertButton_Previews: PreviewProvider {
//    static var previews: some View {
//        EndTicketAlertButton()
//    }
//}
