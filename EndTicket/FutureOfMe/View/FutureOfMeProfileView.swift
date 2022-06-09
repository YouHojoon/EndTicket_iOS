//
//  FutureOfMeProfileView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/09.
//

import SwiftUI

struct FutureOfMeProfileView: View {
    @EnvironmentObject private var imagineViewModel: ImagineViewModel
    
    private let gaugeBaseColor = Color(#colorLiteral(red: 0.8797428608, green: 0.8797428012, blue: 0.8797428608, alpha: 1))
    private let progressBaseColor = Color(#colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 1))
    private let progressCompletedColor = Color(#colorLiteral(red: 0.7568627451, green: 0.7568627451, blue: 0.7568627451, alpha: 1))
    
    var body: some View {
        VStack(alignment:.leading, spacing: 0){
            Text("미래의 나")
                .kerning(-0.5)
                .font(.gmarketSansMeidum(size: 20))
                .padding(.bottom, 43.06)
            Divider().opacity(0)
            
            HStack(spacing:0){
                Circle()
                    .foregroundColor(gaugeBaseColor)
                    .frame(width:84,height: 84)
                    .overlay{Circle()
                            .trim(from: 0, to: 0.95)
                            .stroke(style:StrokeStyle(lineWidth:8, lineCap: .round, lineJoin: .round))
                            .fill()
                            .foregroundColor(gaugeBaseColor)
                            .rotationEffect(.degrees(95))
                            .frame(width:103.87,height: 103.87)
                    }
                    .overlay{Circle()
                            .trim(from: 0.5, to: 0.95)
                            .stroke(style:StrokeStyle(lineWidth:8, lineCap: .round, lineJoin: .round))
                            .fill()
                            .foregroundColor(.blue)
                            .rotationEffect(.degrees(95))
                            .frame(width:103.87,height: 103.87)
                    }
                    .padding(.trailing, 22)
                VStack(alignment:.leading,spacing:0){
                    Text("\"당당하고 멋있는 사람\"")
                        .font(.gmarketSansMeidum(size: 17))
                        .padding(.bottom, 8)
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width:49,height: 20)
                        .foregroundColor(gaugeBaseColor)
                        .overlay{
                            Text("꽃봉오리")
                                .font(.gmarketSansMeidum(size: 10))
                        }
                        .padding(.bottom,6)
                    Text("LV4. 드리밍")
                        .font(.gmarketSansMeidum(size: 15))
                        .frame(height:25)
                }
            }
            .padding(.bottom, 35.94)
            .padding(.leading, 16)
            
            Text("진행상황")
                .font(.gmarketSansMeidum(size: 15))
                .padding(.bottom, 10)
            Divider().padding(.bottom, 12)
            progressView
        }.padding(.horizontal,25)
            .padding(.vertical)
            .background(RoundedRectangle(cornerRadius: 25).foregroundColor(.white).edgesIgnoringSafeArea(.top))
    }
    
    var progressView: some View{
        let numOfCompleted = imagineViewModel.imagines.filter{$0.isCompleted == true}.count
        
        return HStack(spacing:0){
            ForEach(0..<6){index in
                Circle()
                    .foregroundColor(index < numOfCompleted ? progressCompletedColor : progressBaseColor)
                    .frame(width:21,height: 21)
                    .overlay{
                        Text("\(index+1)")
                            .font(.gmarketSansMeidum(size: 10))
                            .foregroundColor(index < numOfCompleted ? .black : .white)
                    }
                if index != 5{
                    Rectangle().frame(height: 3)
                        .foregroundColor(index < numOfCompleted - 1 ? progressCompletedColor : progressBaseColor)
                }
                
            }
        }
    }
}

struct FutureOfMeProfileView_Previews: PreviewProvider {
    static var previews: some View {
        FutureOfMeView_Previews.previews
    }
}
