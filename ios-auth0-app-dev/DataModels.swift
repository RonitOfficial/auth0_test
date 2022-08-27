//
//  DataModels.swift
//  ios-auth0-app-dev
//
//  Created by Ronit Maitra on 26/08/22.
//

import Foundation

struct ServicesDataModel: Codable, Identifiable{
    var id = UUID()
    let title: String?
    let desc: String?
    let url: String?
}
