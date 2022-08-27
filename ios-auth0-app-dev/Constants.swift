//
//  Constants.swift
//  ios-auth0-app-dev
//
//  Created by Ronit Maitra on 26/08/22.
//

import Foundation
import SwiftUI

class Constants{
    static let appTintColor = Color.init(#colorLiteral(red: 0.5876561999, green: 0.3326948881, blue: 0.3525306582, alpha: 1))
    static let servicesList = [
        ServicesDataModel(
            title: "Websites",
            desc: "SEO Optimised, AI-driven, Interactive Websites and Campaigns Driving Engagement & Conversions.",
            url: "https://digitalchameleon.ai/website"
        ),
        ServicesDataModel(
            title: "Forms & Workflows",
            desc: "Fully Integrated Onboarding Workflows and Online Forms Engaging Better Converting More.",
            url: "https://digitalchameleon.ai/workflows"
        ),
        ServicesDataModel(
            title: "Mobile App",
            desc: "Hyper-Personalised Dynamic Native Mobile Apps Interacting in Realtime with your customers.",
            url: "https://demo.digitalchameleon.ai/"
        ),
        ServicesDataModel(
            title: "Chatbot",
            desc: "In-built Industry specific AI-powered Chatbot providing Personalised Assistance.",
            url: "https://digitalchameleon.ai/chatbot"
        )
    ]
}
