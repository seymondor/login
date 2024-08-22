//
//  HomeScreen.swift
//  vkLogin
//
//  Created by Максим Машковский on 27.04.2024.
//

import SwiftUI

struct HomeScreen: View {
    @State private var showingLogScreen = false
    @State private var isLikePressed = false
    @State private var isLike : Bool = false
    //@State private var users : [Int:User] = [1: user1, 2: user2, 3: user3]
    
    var body: some View {
        VStack(spacing: 20) {
            ScrollView(.horizontal){
                HStack(spacing: 10) {
                    ForEach(testSSS, id: \.self) { item in
                        Text(item.username)
                            .foregroundStyle(.white)
                            .frame(width: 70, height: 70)
                            .background(.black)
                            .padding(.bottom)
                    }
                }
                .padding(.leading)
                .padding(.trailing)
            }
            .background(.green)
            ScrollView(.vertical){
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(testSSS, id: \.self) { item in
                        HStack() {
                            Text(item.username)
                                .foregroundStyle(.white)
                                .frame(width: 70, height: 70)
                                .background(.black)
                            Text(item.username)
                        }
                        Image("\(item.imagePost)")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(width: 350, height: 300)
                            .background(.gray)
                            
                        HStack(spacing: 5) {
                            Button {
                                if (item.isLikePressed) {
                                    testSSS[item.id].likes -= 1
                                    isLike = true
                                    testSSS[item.id].isLikePressed = false
                                } else {
                                    testSSS[item.id].likes += 1
                                    isLike = true
                                    testSSS[item.id].isLikePressed = true
                                }
                            } label: {
                                Image(systemName: item.isLikePressed == true ? "heart.fill" : "heart")
                            }
                            
                            Text("\(isLike ? testSSS[item.id].likes : item.likes)")
                        }
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showingLogScreen) {
            ContentView()
        }
    }
}

#Preview {
    HomeScreen()
}
