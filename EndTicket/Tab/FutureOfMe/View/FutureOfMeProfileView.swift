//
//  FutureOfMeProfileView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/09.
//

import SwiftUI
import Alamofire

struct FutureOfMeProfileView: View {
    @EnvironmentObject private var imagineViewModel: ImagineViewModel
    
    private let progressBaseColor = Color(#colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 1))
    private let progressCompletedColor = Color(#colorLiteral(red: 0.7568627451, green: 0.7568627451, blue: 0.7568627451, alpha: 1))
    
    var body: some View {
        VStack(alignment:.leading, spacing: 0){
            Text("미래의 나")
                .kerning(-0.5)
                .font(.system(size: 21,weight: .bold))
                .padding(.bottom, 43.06)
            Divider().opacity(0)
            
            HStack(spacing:0){
                //MARK: - 프로필 게이지 부분
                Circle()
                    .foregroundColor(.gray50)
                    .frame(width:85,height: 85)
                    .overlay{Circle()
                            .stroke(style:StrokeStyle(lineWidth:8, lineCap: .round, lineJoin: .round))
                            .foregroundColor(.gray50)
                            .frame(width:103,height: 103)
                    }
                    .overlay{Circle()
                            .trim(from: 0, to: 1)
                            .rotation(.degrees(-90)) //오른쪽이 0이여서 회전
                            .stroke(style:StrokeStyle(lineWidth:8, lineCap: .round, lineJoin: .round))
                            .fill()
                            .foregroundColor(.blue)
                            .frame(width:103,height: 103)
                    }
                    .overlay{
                        Circle().foregroundColor(.white)
                            .frame(width: 27, height: 27)
                            .overlay{
                                Image("futureOfMe_gear")
                            }
                            .offset(x: 31, y: 31)
                            
                    }
                    .padding(.trailing, 22)
                VStack(alignment:.leading,spacing:0){
                    HStack(spacing:10){
                        Text("\"당당하고 멋있는 사람\"")
                            .font(.system(size: 18,weight: .bold))
                        Image("futureOfMe_edit_icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 19.5, height: 18.94)
                    }.padding(.bottom, 11)
                  
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width:49,height: 20)
                        .foregroundColor(.gray100)
                        .overlay{
                            Text("꽃봉오리")
                                .font(.system(size: 10,weight: .medium))
                                .foregroundColor(.gray700)
                        }
                        .padding(.bottom,6)
                    Text("LV4. 드리밍")
                        .font(.system(size:13, weight: .regular))
                        .frame(height:25)
                }
            }
            .padding(.bottom, 35.94)
            .padding(.leading, 16)
            
//            Text("진행상황")
//                .font(.gmarketSansMeidum(size: 15))
//                .padding(.bottom, 10)
//            Divider().padding(.bottom, 12)
////            progressView
        }.padding(.horizontal,25)
            .padding(.vertical)
            .background(RoundedRectangle(cornerRadius: 25).foregroundColor(.white).edgesIgnoringSafeArea(.top))
    }
//
//    var progressView: some View{
//        let numOfCompleted = imagineViewModel.imagines.filter{$0.isCompleted == true}.count
//
//        return HStack(spacing:0){
//            ForEach(0..<6){index in
//                Circle()
//                    .foregroundColor(index < numOfCompleted ? progressCompletedColor : progressBaseColor)
//                    .frame(width:21,height: 21)
//                    .overlay{
//                        Text("\(index+1)")
//                            .font(.gmarketSansMeidum(size: 10))
//                            .foregroundColor(index < numOfCompleted ? .black : .white)
//                    }
//                if index != 5{
//                    Rectangle().frame(height: 3)
//                        .foregroundColor(index < numOfCompleted - 1 ? progressCompletedColor : progressBaseColor)
//                }
//
//            }
//        }
//    }
}

struct FutureOfMeProfileView_Previews: PreviewProvider {
    static var previews: some View {
        FutureOfMeView_Previews.previews
    }
}
