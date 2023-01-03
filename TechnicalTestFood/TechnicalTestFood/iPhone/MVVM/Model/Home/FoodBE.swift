//
//  FoodBE.swift
//  TechnicalTestFood
//
//  Created by Alexander Ynoñan H. on 3/01/23.
//

import UIKit
import SwiftyJSON

struct FoodBE {

    var name: String?
    var tagline: String?
    var description: String?
    var image: String?

    init(_ json: JSON? = nil) {
        self.name = json?.dictionary?["name"]?.stringValue ?? ""
        self.tagline = json?.dictionary?["name"]?.stringValue ?? ""
        self.description = json?.dictionary?["name"]?.stringValue ?? ""
        self.image = json?.dictionary?["image_url"]?.stringValue ?? ""
    }
}

struct UIFood {
    var page: String
    var search: String
}
