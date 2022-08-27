//
//  SocketService.swift
//  ios-auth0-app-dev
//
//  Created by Ronit Maitra on 25/08/22.
//

import Foundation
import Auth0
import Starscream
import JWTDecode

class SocketService: ObservableObject, WebSocketDelegate{
    @Published var isConnected: Bool = false
    @Published var messages: [Date: String] = [:]
    var socket: WebSocket?
        
    init(){
        Task{
            await self.initWebSocket()
            
            //MARK: Connection through Digitalchameleon 'backend-preprod-api.camiesandbox.com'
            self.socket?.connect()
        }
    }
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch(event){
        case .connected(let data):
            print("\n\nConnection successful: \(data)")
            self.isConnected = true
        case .disconnected(let data1, let data2):
            print("\(data1) || \(data2)")
            _ = data1
            _ = data2
        case .text(let data):
//            print(data)
            self.messages[Date()] = data
        case .binary(let data):
//            print(data)
            _ = data
        case .pong(let data):
//            print(data)
            _ = data
        case .ping(let data):
//            print(data)
            _ = data
        case .error(let data):
            print(data)
            print(data.debugDescription)
            print(data?.localizedDescription)
            _ = data
        case .viabilityChanged(let data):
//            print(data)
            _ = data
        case .reconnectSuggested(let data):
//            print(data)
            _ = data
        case .cancelled:
            print("Cancelled")
        }
    }
    
    func initWebSocket() async {
        do{
            let accessToken = try await ShareStore().credentialManager.credentials().accessToken
            guard let userEmail = ShareStore().credentialManager.user?.email else { return }
            guard let socketUrl = getSocketUrl(userEmail: userEmail, accessToken: accessToken) else { return }
            
            var request = URLRequest(url: socketUrl)
            request.timeoutInterval = 5
            
            self.socket = WebSocket(request: request)
            self.socket?.delegate = self
        }catch _{
            
        }
    }

    func getSocketUrl(userEmail: String, accessToken: String) -> URL?{
        let socketUrl = "wss://backend-preprod-api.camiesandbox.com/api/v1/gatewaymanagement/socket?username=\(userEmail)&clientId=19&channelId=a-b-51&mode=WF&clientDepartmentId=NaN&currentWorkflowId=&cluster=cluster-a&cbsId=3e44203f-7e6d-491b-8651-788f5faa9b97&uowId=c2b991cd-656b-4f5d-a9ca-e2748bec865f&anonTkn=\(accessToken)"
        
        return URL(string: socketUrl)
    }
}
