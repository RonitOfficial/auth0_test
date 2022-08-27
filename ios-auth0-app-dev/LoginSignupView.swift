//
//  ContentView.swift
//  ios-auth0-app-dev
//
//  Created by Ronit Maitra on 18/08/22.
//

import SwiftUI
import CoreData
import Auth0
import JWTDecode
import SDWebImageSwiftUI

struct LoginSignupView: View {
    @State var email = ""
    @State var password = ""
    @State var isLoggedIn = false
    @State var clientId = ""
    @State var domain = ""
    @State var isLoggingIn = false
    @State var isAlertVisible = false
    @ObservedObject var appManager: AppManager = .shared
    
    var body: some View {
        VStack{
            Text("Enter your email address and password to signup/login")
                .multilineTextAlignment(.center)
                .font(.title2.bold())
                .foregroundColor(.white)
                .padding([.horizontal, .top])
            
            TextField("Email", text: self.$email)
                .padding(.top)
                .multilineTextAlignment(.center)
            
            SecureField("Password", text: self.$password)
                .padding(.top)
                .multilineTextAlignment(.center)
            
            HStack{
                Spacer()
                
                Button(action: {
                    Task{
                        Auth0
                            .authentication(clientId: self.clientId, domain: self.domain)
                            .signup(
                                email: self.email,
                                username: "",
                                password: self.password,
                                connection: "Username-Password-Authentication",
                                userMetadata: [:],
                                rootAttributes: [:])
                            .start { result in
                                switch result {
                                case .success(let user):
                                    print("User signed up: \(user)")
                                case .failure(let error):
                                    print("Failed with: \(error.info)")
                                }
                            }
                        
                        ShareStore().isLoggedIn = ShareStore().credentialManager.hasValid()
                    }
                }){
                    Text("Sign Up")
                }
                
                Spacer()
                
                Button(action: {
                    Task{
                        do {
                            self.isLoggingIn = true
                            
                            let credentials = try await Auth0
                                .authentication(clientId: self.clientId, domain: self.domain)
                                .login(
                                    usernameOrEmail: self.email,
                                    password: self.password,
                                    realmOrConnection: "Username-Password-Authentication",
                                    audience: "https://dev-icd2t1nb.au.auth0.com/api/v2/",
                                    scope: "openid profile email offline_access")
                                .start()
                            
                            ShareStore().isLoggedIn = true
                            
                            print("Signup API: \(credentials.accessToken)")
                            
                            _ = ShareStore().credentialManager.store(credentials: credentials)
                            
                            self.isLoggingIn = false
                        } catch {
                            print("Failed with: \(error)")
                            self.isLoggingIn = false
                            self.isAlertVisible.toggle()
                        }
                    }
                    
                }){
                    Text("Login")
                }
                
                Spacer()
            }
            .padding(.top)
            
            Button(action: {
                Task{
                    do{
                        self.isLoggingIn = true
                        
                        let credentials = try await Auth0
                            .webAuth()
                            .audience("https://dev-icd2t1nb.au.auth0.com/api/v2/")
                            .start()
                        
                        ShareStore().isLoggedIn = true
                        
                        print(credentials.accessToken)
                        
                        _ = ShareStore().credentialManager.store(credentials: credentials)
                        
                        self.isLoggingIn = false
                    }catch let err{
                        print(err.localizedDescription)
                        self.isLoggingIn = false
                        self.isAlertVisible.toggle()
                    }
                }
            }){
                Text("Signup/Login using Auth0 portal")
                    .font(.title3)
                    .fontWeight(.medium)
            }
            .padding(.top, 60)
            
            NavigationLink(
                destination: RootTabView(),
                isActive: self.$isLoggedIn
            ){
                EmptyView()
            }
            .isDetailLink(false)
        }
        .navigationBarHidden(true)
        .blur(radius: self.isLoggingIn ? 10:0)
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
        .overlay(
            ZStack{
                Color.gray.opacity(0.55)
                
                ActivityIndicator(self.$isLoggingIn)
            }
                .opacity(self.isLoggingIn ? 1:0)
        )
        .background{
            LinearGradient(
                colors: [Constants.appTintColor.opacity(0.25), .black, .black, Constants.appTintColor.opacity(0.25)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
        }
        .onAppear{
            if let path = Bundle.main.path(forResource: "Auth0", ofType: "plist") {
                let dict = NSDictionary(contentsOfFile: path)
                
                self.clientId = dict!["ClientId"] as! String
                self.domain = dict!["Domain"] as! String
            }
            
            ShareStore().isLoggedIn = ShareStore().credentialManager.hasValid()
        }
        .onReceive(self.appManager.objectWillChange) { _ in
            self.isLoggedIn = ShareStore().isLoggedIn
        }
        .alert("An error occurred.", isPresented: self.$isAlertVisible) {
            Button("Ok") {
                
            }
        } message: {
            Text("Please ensure your credentials are correct.")
        }
    }
}
