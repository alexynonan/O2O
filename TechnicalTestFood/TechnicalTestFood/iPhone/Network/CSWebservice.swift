//
//  CSWebservice.swift
//  TechnicalTestFood
//
//  Created by Alexander Ynoñan H. on 2/01/23.
//

import Alamofire
import SwiftyJSON

struct CSWebservice {
    
    static let sharedInstace = CSWebservice()

    private init () { }
    
    @discardableResult func requestType(
        type serviceType: HTTPMethod,
        url: String,
        params: Parameters? = nil,
        header: HTTPHeaders? = nil,
        successResponse: @escaping Closures.SuccessResponse
    ) -> DataRequest? {

        let request = AF.request(url, method: serviceType,parameters: params, headers: header)
        return request.response { response in
            print("\n\n**********************************************************************")
            print("SERVICIO \(serviceType.rawValue): \(url)")
            print(JSON(response.data ?? MessageAlert.General.errorServiceNotFount))
            successResponse(JSON(response.data ?? ""), response.response?.statusCode ?? 0)
            print("**********************************************************************\n\n")
        }
    }

//    MARK: - VALIDATION RESPONSE DATA DEFAULTS
    func genericResponseData(
        _ response: JSON,
        statusCode: Int,
        success: (_ json: [JSON]) -> Void,
        error: @escaping Closures.FailureResponse
    ) {
        if statusCode == 200 {
            if let data = response.array {
                success(data)
            }else{
                error(MessageAlert.General.errorInformation)
            }
        } else if statusCode == 400 {
            error(self.manageErrorFromResponse(response))
        }else{
            error(self.manageErrorFromResponse(response))
        }
    }

//    MARK: - Validation Responde Message
    
    private func manageErrorFromResponse(_ response: JSON? = nil) -> String{
        if let message = response?.dictionary?["message"] {
            return message.stringValue
        }else{
            return MessageAlert.General.errorServiceNotFount
        }
    }
}
