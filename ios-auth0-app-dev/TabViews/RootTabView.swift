//
//  RootTabView.swift
//  ios-auth0-app-dev
//
//  Created by Ronit Maitra on 25/08/22.
//

import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView{
            Home()
                .tabItem {
                    Image(systemName: "house.fill").renderingMode(.template).foregroundColor(.brown)
                    Text("Home")
                }
            
            Settings()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
        .accentColor(Constants.appTintColor)
        .navigationBarHidden(true)
        .onAppear{
            UITabBar.appearance().backgroundColor = UIColor(.gray.opacity(0.15))
            UITabBar.appearance().unselectedItemTintColor = UIColor(.white)
            UITabBarItem.appearance().setTitleTextAttributes(
                [NSAttributedString.Key.foregroundColor: UIColor(Constants.appTintColor)],
                for: .selected
            )
        }
    }
}
