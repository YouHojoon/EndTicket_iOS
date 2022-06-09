//
//  ImaginViewModel.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/09.
//

import Foundation
import SwiftUI

class ImagineViewModel:ObservableObject{
    @Published public private(set) var imagines = Imagine.getDummys()
    
    
    func toggleIsCompleted(index:Int){
        imagines[index].isCompleted.toggle()
    }
}
