//
//  HomeModel.swift
//  TechnicalTestFood
//
//  Created by Alexander Ynoñan H. on 3/01/23.
//

import Alamofire

class HomeModel: NSObject {

    private enum Constante {
        static let clearText = "''"
        static let textReplacing = "_"
        static let defaultNumber = 1
    }

    private(set) var arrayFoods: [FoodBE]!{
        didSet {
            bindEmployeeViewModelToController()
        }
    }

    private var urlSession : DataRequest?
    private var filterTextController: String!
    var page : Int!
    var statePage : Bool!
    
    private weak var controller: UIViewController?
    private weak var tblFood: UITableView?

    var bindEmployeeViewModelToController : Closures.Success = {}
    var errorViewModelToContoller : Closures.ErrorMessage = { _ in }

    init(tableView: UITableView,toController: UIViewController,searchBar: UISearchBar) {
        super.init()
        tblFood = tableView
        controller = toController
        searchBar.delegate = self
        page = 1
        loadServices()
    }

}

extension HomeModel: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filterTextController = Constante.clearText
        } else {
            filterTextController = searchText.replacingOccurrences(
                of: " ",
                with: Constante.textReplacing)
        }
        self.page = 1
        loadServices()
    }
}

extension HomeModel {
    
    @objc private func loadServices(){
        self.loadCategorias(state: false)
    }
    
    func loadCategorias(state: Bool) {

        let refreshControll = UIActivityIndicatorView(style: .medium)
        refreshControll.hidesWhenStopped = true
        refreshControll.startAnimating()
        tblFood?.tableFooterView = refreshControll

        let data = UIFood(
            page: "\(page ?? 0)",
            search: self.filterTextController ?? Constante.clearText
        )

        urlSession?.suspend()
        urlSession?.cancel()
        urlSession = HomeBL.shared.getCategorias(dicFood: data) { [weak self] foods in
            guard let self = self else { return }
            refreshControll.stopAnimating()
            
            self.page += 1
            
            if foods.count == 0 {
                self.page -= 1
            }
            
            if self.page == 1 {
                self.arrayFoods = foods
            } else {
                for food in foods {
                    self.arrayFoods.append(food)
                }
            }
            
        } errorService: { [weak self] errorMessage in
            guard let self = self else { return }
            refreshControll.stopAnimating()
            self.errorViewModelToContoller(errorMessage)
        }
    }

    func prepareModel(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? HomeDetailViewController {
            guard let obj = sender as? FoodBE else { return }
            controller.didRecieveDataFood(objFood: obj)
        }
    }
}
