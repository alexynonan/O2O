//
//  WebServicesURL.swift
//  TechnicalTestFood
//
//  Created by Alexander Ynoñan H. on 2/01/23.
//

import Foundation

struct WebServicesURL {

    static private let baseURLServices = "https://api.punkapi.com/v2/"

    struct Home {
        static let homeSearchFood = baseURLServices + "beers?food=%@&page=%@&per_page=%@"
    }

}
