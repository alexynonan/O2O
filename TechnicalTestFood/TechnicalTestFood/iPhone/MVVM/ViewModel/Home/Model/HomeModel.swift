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

    lazy private var refreshControll: UIRefreshControl! = {
       var refresh = UIRefreshControl()
        refresh.tintColor = .darkGray
        refresh.addTarget(
            self,
            action: #selector(self.loadServices),
            for: .valueChanged
        )
        return refresh
    }()

    private var filterTextController: String?

    private weak var controller: UIViewController!

    var bindEmployeeViewModelToController : Closures.Success = {}
    var errorViewModelToContoller : Closures.ErrorMessage = { _ in }

    init(tableView: UITableView,toController: UIViewController,searchBar: UISearchBar) {
        super.init()
        tableView.backgroundView = self.refreshControll
        searchBar.delegate = self
        controller = toController
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
        loadServices()
    }
}

extension HomeModel {
    
    @objc private func loadServices(){
        let data = UIFood(page: "1", search: self.filterTextController ?? "''")
        self.loadCategorias(data: data)
    }
    
    private func loadCategorias(data: UIFood) {
        refreshControll.beginRefreshing()
        urlSession?.suspend()
        urlSession?.cancel()
        urlSession = HomeBL.shared.getCategorias(dicFood: data) { [weak self] foods in
            guard let self = self else { return }
            self.refreshControll.endRefreshing()
            self.arrayFoods = foods
        } errorService: { [weak self] errorMessage in
            guard let self = self else { return }
            self.refreshControll.endRefreshing()
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
