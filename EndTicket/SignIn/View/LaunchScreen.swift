//
//  LaunchScreen.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/13.
//

import SwiftUI

struct LaunchScreen: View {
    var body: some View {
        VStack{
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:203, height: 203)
                .overlay(
                    Image("logo_label")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:78,height: 41)
                        .offset(y:21)
                    ,alignment: .bottom)
                .padding(.bottom, 130)
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .background(Color.white.ignoresSafeArea())
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
