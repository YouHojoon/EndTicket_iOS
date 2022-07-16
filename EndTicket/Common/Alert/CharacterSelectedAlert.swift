//
//  CharacterSelectAlert.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/14.
//

import Foundation
import SwiftUI
struct CharacterSelectAlert:View{
    @State private var selectedCharacter: Character = .kia
    @EnvironmentObject private var signUpViewModel: SignUpViewModel
    
    var body: some EndTicketAlert{
        EndTicketAlertImpl{
            VStack(alignment:.leading,spacing:0){
                Group{
                    Text("나와 닮은 캐릭터를 선택해봐요!")
                        .font(.system(size: 16,weight: .bold))
                        .foregroundColor(.gray500)
                        .padding(.bottom,22)
                        .padding(.top,40)
                    HStack(spacing:0){
                        ForEach(Array(Character.allCases.enumerated()),id: \.1){index,character in
                            Circle()
                                .stroke(character == selectedCharacter ? Color.mainColor : .white,lineWidth: 3)
                                .frame(width:88,height: 88)
                                .overlay{
                                    Circle().frame(width:85,height: 85)
                                        .foregroundColor(.gray50)
                                        .overlay{
                                            character.image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width:70, height:70)
                                        }
                                        .onTapGesture{
                                            selectedCharacter = character
                                        }
                                }
                            
                            if index != Character.allCases.count - 1{
                                Spacer(minLength: 20)
                            }
                        }
                    }.padding(.bottom,35)
                    Text("\(selectedCharacter.rawValue)")
                        .font(.system(size:22, weight:.bold))
                        .padding(.bottom,5)
                    Text("\(selectedCharacter.info)")
                        .font(.system(size:15,weight: .bold))
                        .foregroundColor(Color.gray700)
                        .padding(.bottom,50)
                }.padding(.horizontal,20)
            }
        }primaryButton: {
            EndTicketAlertButton(label:Text("선택하기").foregroundColor(.white),color:Color.mainColor){
                signUpViewModel.signUpCharacter(selectedCharacter)
            }
        }
    }
}

