//
//  SocketView.swift
//  ios-auth0-app-dev
//
//  Created by Ronit Maitra on 24/08/22.
//

import SwiftUI
import Starscream
import Auth0

struct SocketView: View {
    @StateObject var service = SocketService()
    
    var body: some View {
        ScrollView{
            if(self.service.isConnected){
                ForEach(service.messages.sorted(by: <), id: \.key){
                    Text($0.value)
                }
            }
        }
        .onDisappear{
            self.service.socket = nil
        }
    }
}
