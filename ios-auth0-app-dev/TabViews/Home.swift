//
//  Home.swift
//  ios-auth0-app-dev
//
//  Created by Ronit Maitra on 24/08/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct Home: View {
    @State var isCamieAvatarVisible = false
    @State var isCamieAvatarTapped = false
    
    var body: some View {
        ZStack{
            ScrollView(.vertical, showsIndicators: false){
                Group{
                    Image("AppIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.screenWidth/3)
                        .animation(.easeIn)
                    
                    Text("AI-powered No-code Chameleon")
                        .font(.title2)
                        .foregroundColor(Constants.appTintColor)
                        .padding(.top)
                    
                    Text("Turning ideas into extraordinary digital products & experiences.")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                
                CustomVideoPlayer(videoUrl: "")
                    .frame(height: UIScreen.screenWidth * 0.8)
                
                Group{
                    Text("We're empowering businesses to create ")
                        .font(.title2)
                        .foregroundColor(Constants.appTintColor)
                        .padding(.top)
                    
                    Text("stunning digital experiences without coding.")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                
                Text("What would you like to use Chameleon for?")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 0, maximum: UIScreen.screenWidth / 2)),
                    GridItem(.flexible(minimum: 0, maximum: UIScreen.screenWidth / 2))
                ]){
                    ForEach(Constants.servicesList){
                        ServicesCardView(data: $0)
                    }
                }
                .padding(.bottom, 150)
                .padding(.horizontal, 10)
            }
            
            VStack(alignment: .trailing){
                Spacer()
                
                NavigationLink(
                    destination: SocketView(),
                    isActive: self.$isCamieAvatarTapped
                ){
                    HStack{
                        Spacer()
                        
                        Text("Need a helping paw?")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .frame(width: 70)
                        
                        WebImage(url: URL(string: "https://fovl6v43p9.execute-api.ap-southeast-2.amazonaws.com/preprod/api/v1/behaviourresponsemanagement/s3/downloadImage/19/bhv/a804c889-7db2-42bd-840f-79ecb047b508.png")!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.screenWidth/4)
                            .frame(alignment: .bottomTrailing)
                    }
                    .frame(width: UIScreen.screenWidth/2)
                    .background(Color.black.cornerRadius(10).opacity(0.75))
                    .padding(.all, 2)
                    .opacity(self.isCamieAvatarVisible ? 1:0)
                    .onTapGesture {
                        withAnimation {
                            self.isCamieAvatarTapped = true
                        }
                    }
                }
                .isDetailLink(false)
            }
            .frame(width: UIScreen.screenWidth, alignment: .trailing)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear{
            withAnimation(.easeIn(duration: 2)){
                self.isCamieAvatarVisible = true
            }
        }
    }
}
