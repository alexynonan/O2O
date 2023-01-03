//
//  HomeBL.swift
//  TechnicalTestFood
//
//  Created by Alexander Ynoñan H. on 3/01/23.
//

import Alamofire

struct HomeBL {

    static let shared = HomeBL()
    
    private init() { }
    
    func getCategorias(
        dicFood: UIFood,
        completion: @escaping Closures.Home.SuccessFood,
        errorService: @escaping Closures.ErrorMessage
    ) -> DataRequest? {

        HomeWS.shared.getCategorias(
            dicFood: dicFood,
            completion: completion,
            errorService: errorService
        )
    }
}
