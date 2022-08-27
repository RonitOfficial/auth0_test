//
//  ServicesCardView.swift
//  ios-auth0-app-dev
//
//  Created by Ronit Maitra on 26/08/22.
//

import Foundation
import SwiftUI
import WebKit
import SDWebImageSwiftUI

struct ServicesCardView: View{
    @State var data: ServicesDataModel
    @State var isCardTapped = false
    
    var body: some View{
        NavigationLink(
            destination: ServicesWebView(model: WebViewModel(link: self.data.url!)),
            isActive: self.$isCardTapped
        ){
            VStack{
                Text(data.title ?? "Empty Title")
                    .font(.title2)
                    .foregroundColor(Constants.appTintColor)
                    .padding(.top)
                
                Text(data.desc ?? "Empty Description")
                    .font(.footnote)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding([.bottom, .horizontal])
            }
            .frame(minHeight: UIScreen.screenHeight / 4.5)
            .background(.gray.opacity(0.15))
            .cornerRadius(15)
            .onTapGesture {
                self.isCardTapped = true
            }
        }
    }
}

struct ServicesWebView: View{
    @ObservedObject var model: WebViewModel
    @State var isLoading: Bool = true
    
    var body: some View{
        ZStack{
            WebView(viewModel: model)
                .onReceive(model.$didFinishLoading) { status in
                    self.isLoading = !status
                }
            
            if(self.isLoading){
                Color.gray
                    .overlay(
                        ActivityIndicator(self.$isLoading)
                    )
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
