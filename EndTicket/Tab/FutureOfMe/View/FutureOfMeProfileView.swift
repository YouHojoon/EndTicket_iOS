//
//  FutureOfMeProfileView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/09.
//

import SwiftUI
import Alamofire
import Kingfisher
struct FutureOfMeProfileView: View {
    @EnvironmentObject private var viewModel: FutureOfMeViewModel
    @State private var futureOfMe: FutureOfMe? = nil
    private let progressBaseColor = Color(#colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 1))
    private let progressCompletedColor = Color(#colorLiteral(red: 0.7568627451, green: 0.7568627451, blue: 0.7568627451, alpha: 1))
    
    var body: some View {
        VStack(alignment:.leading, spacing: 0){
            HStack(spacing:0){
                //MARK: - 프로필 게이지 부분
                Circle().stroke(style:StrokeStyle(lineWidth:8, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.gray50)
                    .frame(width:103,height: 103)
                    .overlay{
                        //채워지는 부분
                        Circle()
                            .trim(from: 0, to: CGFloat(futureOfMe?.experience ?? 0) / 100)
                            .rotation(.degrees(-90)) //오른쪽이 0이여서 회전
                            .stroke(style:StrokeStyle(lineWidth:8, lineCap: .round, lineJoin: .round))
                            .fill()
                            .foregroundColor(Character.getCharaterType(id: futureOfMe?.id ?? 0).color)
                            .frame(width:103,height: 103)
                    }
                    .overlay{//캐릭터
                        Circle()
                            .foregroundColor(.gray50)
                            .frame(width:85,height: 85)
                            .overlay{
                                if let imageUrl = futureOfMe?.characterImageUrl{
                                    KFImage(imageUrl)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 70, height: 70)
                                }
                                else{
                                    EmptyView()
                                }
                            }
                    }
                    .offset(x: -8)
                    .padding(.trailing, 22)
                
                VStack(alignment:.leading,spacing:10){
                    if let subject = futureOfMe?.subject, !subject.isEmpty{
                        Text(subject)
                            .font(.system(size: 18,weight: .bold))
                    }else{
                        Text("미래의 나를 적어주세요.")
                            .font(.system(size: 18,weight: .bold))
                            .foregroundColor(.gray300)
                    }
                    
                    Text(futureOfMe?.title ?? "랜선 여행가")
                        .font(.system(size: 10,weight: .medium))
                        .padding(.horizontal, 10)
                        .frame(height: 20)
                        .overlay{
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray200)
                        }.padding(.vertical, 1)
                    
                    Text("LV\(futureOfMe?.level ?? 1). \(viewModel.futureOfMe?.nickname ?? EssentialToSignIn.nickname.saved!)")
                        .font(.system(size:13, weight: .bold))
                        .foregroundColor(.gray500)
                }
                Spacer()
            }
            .padding(.bottom, 35.94)
            .padding(.leading, 16)
            
        }.padding(.horizontal,25)
        .padding(.top,20)
        .background(Color.white.edgesIgnoringSafeArea(.top))
        .onAppear{
            viewModel.fetchFutureOfMe()
        }
        .onReceive(viewModel.$futureOfMe){
            if $0 != nil{
                futureOfMe = $0
            }
        }
    }
}

struct FutureOfMeProfileView_Previews: PreviewProvider {
    static var previews: some View {
        FutureOfMeProfileView().environmentObject(FutureOfMeViewModel())
    }
}
