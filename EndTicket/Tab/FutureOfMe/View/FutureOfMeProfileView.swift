//
//  FutureOfMeProfileView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/09.
//

import SwiftUI
import Alamofire

struct FutureOfMeProfileView: View {
    @EnvironmentObject private var viewModel: FutureOfMeViewModel
    @State private var shouldShowAlert = false
    @State private var subject = ""
    private let progressBaseColor = Color(#colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 1))
    private let progressCompletedColor = Color(#colorLiteral(red: 0.7568627451, green: 0.7568627451, blue: 0.7568627451, alpha: 1))
    
    var body: some View {
        VStack(alignment:.leading, spacing: 0){
            HStack{
                Text("미래의 나")
                    .kerning(-0.5)
                    .font(.system(size: 21,weight: .bold))
                Spacer()
                Image("futureOfMe_edit_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 19.5, height: 18.94)
                    .onTapGesture{
                        shouldShowAlert = true
                    }
                
            }.padding(.bottom, 33)
            
            HStack(spacing:0){
                //MARK: - 프로필 게이지 부분
                Circle().stroke(style:StrokeStyle(lineWidth:8, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.gray50)
                    .frame(width:103,height: 103)
                    .overlay{
                        //채워지는 부분
                        Circle()
                            .trim(from: 0, to: CGFloat(viewModel.futureOfMe?.experience ?? 0) / 100)
                            .rotation(.degrees(-90)) //오른쪽이 0이여서 회전
                            .stroke(style:StrokeStyle(lineWidth:8, lineCap: .round, lineJoin: .round))
                            .fill()
                            .foregroundColor(.blue)
                            .frame(width:103,height: 103)
                    }
                    .overlay{//캐릭터
                        Circle()
                            .foregroundColor(.gray50)
                            .frame(width:85,height: 85)
                    }
                    .offset(x: -8)
                    .padding(.trailing, 22)
                
                VStack(alignment:.leading,spacing:0){
                    
                    if let subject = viewModel.futureOfMe?.subject{
                         Text(subject)
                            .font(.system(size: 18,weight: .bold))
                            .padding(.bottom,10)
                    }else{
                        Text("미래의 나를 적어주세요.")
                           .font(.system(size: 18,weight: .bold))
                           .foregroundColor(.gray300)
                           .padding(.bottom,10)
                    }
                 
                    Text(viewModel.futureOfMe?.title ?? "랜선 여행가")
                        .font(.system(size: 10,weight: .medium))
                        .padding(.horizontal, 10)
                        .overlay{
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray200)
                                .frame(height: 20)
                        }.padding(.bottom, 1)
                        
                    Text("LV\(viewModel.futureOfMe?.level ?? 0). \(viewModel.futureOfMe?.nickname ?? UserDefaults.standard.string(forKey: "nickname")!)")
                        .font(.system(size:13, weight: .bold))
                        .frame(height:25)
                        .foregroundColor(.gray500)
                }
                Spacer()
            }
            .padding(.bottom, 35.94)
            .padding(.leading, 16)
            
        }.padding(.horizontal,25)
            .padding(.vertical)
            .background(Color.white.edgesIgnoringSafeArea(.top))
            .onAppear{
                viewModel.getFutureOfMe()
                
            }.alert(isPresented: $shouldShowAlert){
                EndTicketAlert{
                    VStack{
                        Text("미래의 나를 한마디로 설명해줄래요?")
                            .font(.system(size: 18, weight: .bold))
                            .padding(.bottom, 15)
                        FormTextField(text: $subject,height: 35, maxTextLength: 13,borderColor: .gray300)
                            
                    }.padding(.horizontal, 20)
                        .padding(.bottom,30)
                        .padding(.top, 40)
                }primaryButton: {
                    EndTicketAlertButton(label: Text("취소").foregroundColor(.gray400)){
                        shouldShowAlert = false
                    }
                }secondaryButton: {
                    EndTicketAlertButton(label: Text("제목짓기").foregroundColor(.mainColor)){
                        viewModel.postFutureOfMeSubject(subject)
                        shouldShowAlert = false
                    }
                }
            }
    }
}

struct FutureOfMeProfileView_Previews: PreviewProvider {
    static var previews: some View {
        FutureOfMeProfileView().environmentObject(FutureOfMeViewModel())
    }
}
