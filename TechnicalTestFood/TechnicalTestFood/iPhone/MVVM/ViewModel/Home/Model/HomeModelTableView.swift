//
//  HomeModelTableView.swift
//  TechnicalTestFood
//
//  Created by Alexander Ynoñan H. on 3/01/23.
//

import UIKit

class HomeModelTableView: NSObject {
    
    private var arrayFoods: [FoodBE]!
    private var selectCell: (HomeFoodTableViewCell, IndexPath) -> () = {_ ,_ in }
    
    init(items : [FoodBE],completion : @escaping (HomeFoodTableViewCell, IndexPath) -> ()) {
        self.arrayFoods = items
        self.selectCell = completion
    }

}

extension HomeModelTableView : UITableViewDelegate, UITableViewDataSource {
     
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
        guard let cell = tableView.cellForRow(at: indexPath) as? HomeFoodTableViewCell else { return }
        selectCell(cell,indexPath)
    }
}
