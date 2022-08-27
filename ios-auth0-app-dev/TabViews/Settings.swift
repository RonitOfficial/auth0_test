//
//  Settings.swift
//  ios-auth0-app-dev
//
//  Created by Ronit Maitra on 25/08/22.
//

import SwiftUI
import Auth0

struct Settings: View {    
    var body: some View {
        ZStack{
            Button(action: {
                Auth0
                    .webAuth()
                    .clearSession { result in
                        switch result {
                        case .success:
                            print("Logged out")
                        case .failure(let error):
                            print("Failed with: \(error)")
                        }
                    }
                
                _ = ShareStore().credentialManager.clear()
                
                ShareStore().isLoggedIn = ShareStore().credentialManager.hasValid()
            }){
                VStack(alignment: .center){
                    Image(systemName: "power")
                        .resizable()
                        .frame(width: UIScreen.screenWidth * 0.15, height: UIScreen.screenWidth * 0.15)
                        .foregroundColor(.red)
                    
                    Text("Logout")
                        .font(.title2.bold())
                        .foregroundColor(.red)
                }
                .frame(alignment: .center)
            }
        }
        .navigationBarHidden(true)
    }
}
