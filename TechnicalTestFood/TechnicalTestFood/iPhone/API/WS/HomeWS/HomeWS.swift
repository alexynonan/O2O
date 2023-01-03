//
//  HomeWS.swift
//  TechnicalTestFood
//
//  Created by Alexander Ynoñan H. on 3/01/23.
//

import Alamofire

struct HomeWS {

    static let shared = HomeWS()
    
    private init() { }
    
    func getCategorias(
        dicFood: UIFood,
        completion: @escaping Closures.Home.SuccessFood,
        errorService: @escaping Closures.ErrorMessage
    ) -> DataRequest? {

        let endpoint = String(
            format: WebServicesURL.Home.homeSearchFood,
            arguments: [ dicFood.search,
                         dicFood.page,
                        "15"]
        )

        return CSWebservice.sharedInstace.requestType(
            type: .get,
            url: endpoint
        ) { response, status in
            CSWebservice.sharedInstace.genericResponseData(response, statusCode: status, success: { json in
                completion(json.map({ FoodBE($0) }))
            }, error: errorService)
        }
    }
}
