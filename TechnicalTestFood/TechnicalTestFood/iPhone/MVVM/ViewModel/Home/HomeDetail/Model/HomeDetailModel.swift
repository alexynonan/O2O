//
//  HomeDetailModel.swift
//  TechnicalTestFood
//
//  Created by Alexander Ynoñan H. on 3/01/23.
//

import UIKit

class HomeDetailModel: NSObject {

    private weak var controller: UIViewController!
    var successFood: Closures.HomeDetail.SuccessFood = { _ in }
    private var objFood: FoodBE!
    
    init(toController: UIViewController,obj: FoodBE) {
        super.init()        
        controller = toController
        objFood = obj
    }
    
}

extension HomeDetailModel {

    func exitController() {
        controller.navigationController?.popViewController(
            animated: true
        )
    }

    func loadFood() {
        DispatchQueue.main.async {
            self.successFood(self.objFood)
        }
    }
}
