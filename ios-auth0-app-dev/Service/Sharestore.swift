//
//  Sharestore.swift
//  ios-auth0-app-dev
//
//  Created by Ronit Maitra on 25/08/22.
//

import Foundation
import Auth0
import SwiftUI
import Combine

//class Store: ObservableObject{
//    @Published var isLoggedIn = false
//    @Published var credentialManager = CredentialsManager(authentication: Auth0.authentication())
//    @Published var timer = Timer.publish(every: 1, on: .main, in: .common)
//}
class Store: NSObject, ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
}
class AppManager: Store{
    static let shared = AppManager()
    
    @Published var isLoggedIn = false{
        didSet{
            self.objectWillChange.send()
        }
    }
    @Published var credentialManager = CredentialsManager(authentication: Auth0.authentication())
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common)
    
    private override init() {
//        timer.connect()
    }
}

func ShareStore() -> AppManager {
    return AppManager.shared
}
