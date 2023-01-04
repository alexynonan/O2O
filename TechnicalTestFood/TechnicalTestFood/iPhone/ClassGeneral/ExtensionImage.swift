//
//  ExtensionImage.swift
//  TechnicalTestFood
//
//  Created by Alexander Ynoñan H. on 3/01/23.
//

import Alamofire

extension UIImageView {

    func downloadImageView(url : String, completionImage : @escaping Closures.Image){
        self.image = nil
        let urlService = url
        let request = AF.request(urlService, method: .get)
        request.response { response in
            
            if response.response?.url?.absoluteString == urlService {
                
                guard let data = response.data else {
                    completionImage(UIImage())
                    return
                }
                
                guard let image = UIImage(data: data) else {
                    completionImage(UIImage())
                    return
                }
                completionImage(image)
            }
        }
    }
}
