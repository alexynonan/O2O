//
//  Closures.swift
//  TechnicalTestFood
//
//  Created by Alexander Ynoñan H. on 2/01/23.
//

import SwiftyJSON
import Foundation

struct Closures {

    //MARK: General
    typealias ErrorMessage = (_ errorMessage: String) -> Void
    typealias Message = (_ message: String) -> Void
    typealias Success = () -> Void
    typealias Image = (_ image: UIImage)   -> Void

    //MARK: WebServices
    typealias SuccessResponse = (_ response: JSON,_ status: Int) -> Void
    typealias FailureResponse = (_ errorMessage: String) -> Void

    struct Home {
        typealias SuccessFood = (_ foods: [FoodBE]) -> Void
    }
}
