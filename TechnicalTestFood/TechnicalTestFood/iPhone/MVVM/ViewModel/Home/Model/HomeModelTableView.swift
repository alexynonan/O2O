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
    var scrollBottom: Closures.Success = { }

    init(items : [FoodBE],toController: UIViewController) {
        super.init()
        arrayFoods = items
        controller = toController
    }

}

extension HomeModelTableView : UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayFoods.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "HomeFoodTableViewCell",
            for: indexPath) as! HomeFoodTableViewCell
        cell.objFood = self.arrayFoods[indexPath.row]
        cell.selectionStyle = .none
        return cell
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

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY + scrollView.frame.size.height > contentHeight + 40 {
            scrollBottom()
        }
        
//        if offsetY > contentHeight - scrollView.frame.height {
//            scrollBottom()
//        }
    }
}
