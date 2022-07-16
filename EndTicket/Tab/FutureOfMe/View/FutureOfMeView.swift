//
//  FutureOfMeView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/08.
//

import SwiftUI

struct FutureOfMeView: View {
    @State private var shouldShowImagineFormView = false
    @State private var shouldShowAlert = false
    @State private var imagines: [Imagine] = []
    @EnvironmentObject private var viewModel: FutureOfMeViewModel
    @Environment(\.scenePhase) var scensPhase
    init(){
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        VStack(spacing:0){
            //MARK: - 상단 프로필
            FutureOfMeProfileView()
                .padding(.bottom ,30)
            
            //MARK: - 상상해보기
            Group{
                HStack{
                    Text("상상하기")
                        .font(.system(size: 16,weight: .bold))
                    
                    Spacer()
                    Button{
                        if viewModel.imagines.count == 6{
                            shouldShowAlert = true
                        }
                        else{
                            withAnimation(.easeInOut){
                                shouldShowImagineFormView = true
                            }
                        }
                    }label: {
                        Image(systemName: "plus")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(Color(#colorLiteral(red: 0.7568627451, green: 0.7568627451, blue: 0.7568627451, alpha: 1)))
                    }
                }.padding(.bottom,12)
                Divider().padding(.bottom, 21)
                
                ScrollView(showsIndicators:false){
                    if !imagines.isEmpty{
                        VStack(alignment:.leading,spacing:20){
                            ForEach(imagines, id: \.id){index in
                                ImagineView(index)
                                
                            }
                        }
                    }
                    else{
                        VStack(spacing:0){
                            Image("futureOfMe_image")
                                .frame(width: 208, height: 201)
                                .padding(.bottom,5)
                            Text("미래의 나는 어떨지 상상해보세요:)")
                                .font(.interSemiBold(size: 14))
                                .padding(.bottom,20)
                            Button{
                                shouldShowImagineFormView = true
                            }label: {
                                Text("상상하기")
                                    .font(.system(size: 15,weight: .bold))
                                    .frame(maxWidth:.infinity, minHeight: 50, maxHeight: 50)
                                    .foregroundColor(.white)
                            }.background(Color.mainColor)
                                .cornerRadius(10)
                        }
                    }
                    
                }
            }.padding(.horizontal, 25)
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)).ignoresSafeArea())
        .fullScreenCover(isPresented:$shouldShowImagineFormView){
            ImagineFormView()
        }
        .onAppear{
            print(EssentialToSignIn.token.saved)
            viewModel.fetchImagines()
        }
        .onReceive(viewModel.fetchImagineTrigger){
            imagines = viewModel.imagines
        }
        .animation(.easeInOut, value: imagines)
        //MARK: - alert
        .maxContentAlert(isPresented: $shouldShowAlert)
    }
}

struct FutureOfMeView_Previews: PreviewProvider {
    static var previews: some View {
        FutureOfMeView().environmentObject(FutureOfMeViewModel())
    }
}
