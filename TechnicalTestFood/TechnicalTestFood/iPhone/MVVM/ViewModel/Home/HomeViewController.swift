//
//  HomeViewController.swift
//  TechnicalTestFood
//
//  Created by Alexander Ynoñan H. on 3/01/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var tblFood: UITableView!
    @IBOutlet private weak var foodSearch: UISearchBar! {
        didSet{
            UITextField.appearance(
                whenContainedInInstancesOf: [UISearchBar.self]
            ).textColor = .black
        }
    }

    private var homeModel: HomeModel!
    private var homeModelTable: HomeModelTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadHome()
        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        homeModel.prepareModel(for: segue, sender: sender)
    }

}

extension HomeViewController {
    
    private func loadHome() {
        homeModel = HomeModel(
            tableView: tblFood,
            toController: self,
            searchBar: foodSearch
        )

        homeModel.bindEmployeeViewModelToController = { [weak self] in
            guard let self = self else { return }
            self.loadTableView()
        }
    }

    private func loadTableView() {
        homeModelTable = HomeModelTableView(
            items: homeModel.arrayFoods,
            toController: self
        )
        tblFood.delegate = homeModelTable
        tblFood.dataSource = homeModelTable
        tblFood.reloadData()

        homeModelTable.scrollBottom = { [weak self] in
            guard let self = self else { return }
            self.homeModel.loadCategorias(state: true)
        }
    }
    
}
