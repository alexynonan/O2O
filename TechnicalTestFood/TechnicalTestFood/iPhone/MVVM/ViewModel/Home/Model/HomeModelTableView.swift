//
//  HomeModelTableView.swift
//  TechnicalTestFood
//
//  Created by Alexander Ynoñan H. on 3/01/23.
//

import UIKit

class HomeModelTableView: NSObject {

    private enum Constante {
        static let noInformation = "Sin Información"
        static let defaultNumber = 1
    }

    private var arrayFoods: [FoodBE]!
    private weak var controller: UIViewController!

    init(items : [FoodBE],toController: UIViewController) {
        super.init()
        arrayFoods = items
        controller = toController
    }

}

extension HomeModelTableView : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayFoods.isEmpty ? Constante.defaultNumber : arrayFoods.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if arrayFoods.isEmpty {

            let cell = tableView.dequeueReusableCell(
                withIdentifier: "MessageTableViewCell",
                for: indexPath) as! MessageTableViewCell
            cell.message = Constante.noInformation
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "HomeFoodTableViewCell",
                for: indexPath) as! HomeFoodTableViewCell
            cell.objFood = self.arrayFoods[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let _ = tableView.cellForRow(
            at: indexPath
        ) as? HomeFoodTableViewCell else {
            return
        }
        controller.performSegue(
            withIdentifier: Segue.homeDetailViewController,
            sender: arrayFoods[indexPath.row]
        )
    }
}
