//
//  ios_auth0_app_devApp.swift
//  ios-auth0-app-dev
//
//  Created by Ronit Maitra on 18/08/22.
//

import SwiftUI

@main
struct ios_auth0_app_devApp: App {

    var body: some Scene {
        WindowGroup {
            NavigationView{
                LoginSignupView()
            }
            .colorScheme(.dark)
        }
    }
}
