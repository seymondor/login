//
//  ContentView.swift
//  vkLogin
//
//  Created by Максим Машковский on 20.04.2024.
//

import SwiftUI
import FirebaseAuth


struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordAgain: String = ""
    @State private var isUserSignedUp: Bool = false
    @State private var showingAlert = false
    @State private var text = ""
    @State private var isUserEnteredIn = false
    @State private var isWantToSignIn = false
    @State private var textOfSignUpOrInButton = "Sign In"
    @State private var textOfWantSignUpOrInButton = "Want to Sign Up?"
    @State private var isPresentedHomeScreen = false
    @State private var showingHomeScreen = false
    @State private var isSecured = true
    @State private var showPasswordAgain = false
    
    
    var body: some View {
        if isUserEnteredIn {
            // do smth
        } else {
            content
        }
    }
    
    var content: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            VStack {
                TextField("email", text: $email)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .background(.white)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .textContentType(.givenName)
                    .padding()
                HStack(spacing: 0) {
                    if isSecured {
                        Button {
                            isSecured = false
                        } label: {
                            Image(systemName: "eye.fill")
                                .font(.system(size: 30))
                                .frame(width: 60, height: 40, alignment: .center)
                        }
                        .foregroundColor(.black)
                        .background(.white)
                        .padding()
                        SecureField("password", text: $password)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .background(.white)
                            .multilineTextAlignment(.center)
                            .textContentType(.givenName)
                            .font(.system(size: 30))
                            .padding()
                    } else {
                        Button {
                            isSecured.toggle()
                        } label: {
                            Image(systemName: "eye.slash.fill")
                                .font(.system(size: 30))
                                .frame(width: 60, height: 40, alignment: .center)
                        }
                        .foregroundColor(.black)
                        .background(.white)
                        .padding()
                        TextField("password", text: $password)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .background(.white)
                            .font(.system(size: 30))
                            .multilineTextAlignment(.center)
                            .textContentType(.givenName)
                            .padding()
                    }
                }
                
                if showPasswordAgain {
                    HStack {
                        if isSecured {
                            SecureField("repeat password", text: $passwordAgain)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                                .background(.white)
                                .multilineTextAlignment(.center)
                                .textContentType(.givenName)
                                .font(.system(size: 30))
                                .padding()
                                .animation(.easeIn, value: 10)
                        } else {
                            TextField("repeat password", text: $passwordAgain)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                                .background(.white)
                                .font(.system(size: 30))
                                .multilineTextAlignment(.center)
                                .textContentType(.givenName)
                                .padding()
                                .animation(.easeIn, value: 10)
                        }
                    }
                }
                
                Button(textOfSignUpOrInButton) {
                    if isWantToSignIn == false {
                        login()
                    } else {
                        if passwordAgain == password {
                            register()
                        } else {
                            text = "Password doesn't match"
                            showingAlert.toggle()
                        }
                    }
                } .multilineTextAlignment(.center)
                    .foregroundColor(.blue)
                    .background(.white)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                Button(textOfWantSignUpOrInButton) {
                    if isWantToSignIn == false {
                        showPasswordAgain.toggle()
                        textOfSignUpOrInButton = "Sign Up"
                        textOfWantSignUpOrInButton = "Want to Sign In?"
                        isWantToSignIn = true
                    } else {
                        showPasswordAgain = false
                        textOfSignUpOrInButton = "Sign In"
                        textOfWantSignUpOrInButton = "Want to Sign Up?"
                        isWantToSignIn = false
                    }
                } .multilineTextAlignment(.center)
                    .foregroundColor(.blue)
                    .background(.white)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
            }
            .alert(text, isPresented: $showingAlert) {
                Button {
                } label: {
                    Text("OK")
                }
            }
            .fullScreenCover(isPresented: $showingHomeScreen) {
                HomeScreen()
            }
        }
    }
    
    func login() {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard let error = error else {
                showingHomeScreen.toggle()
                return
            }
            text = "Error '\(error.localizedDescription)'"
            showingAlert.toggle()
        }
    }
    
    
    func register() {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard let error = error else {
                text = "Successfully signed up!"
                showingAlert.toggle()
                return
            }
            text = "Error '\(error.localizedDescription)'"
            showingAlert.toggle()
        }
    }
    
}

#Preview {
    ContentView()
}
