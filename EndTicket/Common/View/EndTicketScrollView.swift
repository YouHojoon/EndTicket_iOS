//
//  EndTicketScrollView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/16.
//

import Foundation
import SwiftUI
struct EndTicketScrollView<Content>: View where Content:View{
    let content: Content
    
    @Binding private var isNotScrolled:Bool
    @State private var isCanDetectScroll = false
    
    init(isNotScrolled:Binding<Bool>, content: () -> Content){
        self.content = content()
        _isNotScrolled = isNotScrolled
    }
    
    var body: some View{
        ScrollView(showsIndicators: false){
            content
            .background(GeometryReader { proxy -> Color in
                if isCanDetectScroll {
                    DispatchQueue.main.async {
                        withAnimation{
                            isNotScrolled = proxy.frame(in: .named("scroll")).minY >= 0
                        }
                    }
                }
                return Color.clear
            })
            .background(
                GeometryReader { proxy -> Color in
                    DispatchQueue.main.async {
                        //컨텐츠가 응원문구를 가릴정도로 많은가?
                        isCanDetectScroll = proxy.frame(in: .named("scroll")).size.height >= UIScreen.main.bounds.size.height - 100
                    }
                    
                    return Color.clear
                }
            )
        }.coordinateSpace(name: "scroll")
    }
}
