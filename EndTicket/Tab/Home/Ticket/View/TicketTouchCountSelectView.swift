//
//  TicketTouchCountSelectView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/17.
//

import SwiftUI

struct TicketTouchCountSelectView: View {
    private let touchCounts = [5,10,15]
    private let isEssential: Bool
    @Binding private var selected: Int
    
    init(selected:Binding<Int>, isEssential:Bool = false){
        _selected = selected
        self.isEssential = isEssential
    }
    
    var body: some View {
        VStack(alignment:.leading,spacing:4){
            HStack(alignment:.top,spacing:1){
                Text("스와이프 횟수")
                if isEssential{
                    Image("essential_mark")
                        .padding([.leading,.top],2)
                }
            }.font(.interBold(size: 16))
            .padding(.bottom,10)
            
            LazyVGrid(columns:Array.init(repeating: GridItem(.flexible()), count: touchCounts.count)){
                ForEach(0..<touchCounts.count){index in
                    VStack(spacing:8.94){
                        let touchCount = touchCounts[index]
                        
                        Text("\(touchCounts[index])회").font(.system(size: 16,weight: .bold))
                            .foregroundColor(touchCount == selected ? Color.black : Color.gray300)
                        Circle().stroke(touchCount == selected ? Color.mainColor : Color.gray300, lineWidth:1.5)
                            .frame(width:15,height:15)
                            .overlay(Circle()
                                .frame(width:9,height:9)
                                .foregroundColor(touchCount == selected ? Color.mainColor : Color.gray300))
                    }.padding(.vertical, 20)
                    .padding(.horizontal, 33)
                    .contentShape(Rectangle())
                    .onTapGesture{
                        selected = touchCounts[index]
                    }
                }
            }.background(.white)
                .cornerRadius(10)
        }
    }
}

struct TicketTouchCountSelectView_Previews: PreviewProvider {
    static var previews: some View {
        HStack(alignment:.top,spacing:1){
            Text("스와이프 횟수")
            Image("essential_mark")
                .padding([.leading,.top],2)
        }.font(.interBold(size: 16))
    }
}
