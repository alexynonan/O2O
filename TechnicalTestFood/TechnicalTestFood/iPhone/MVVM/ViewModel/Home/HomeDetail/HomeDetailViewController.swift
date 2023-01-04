//
//  HomeDetailViewController.swift
//  TechnicalTestFood
//
//  Created by Alexander Ynoñan H. on 3/01/23.
//

import UIKit

class HomeDetailViewController: UIViewController {
    
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblDescription: UILabel!
    @IBOutlet private weak var lblTagline: UILabel!
    @IBOutlet private weak var imgFood: UIImageView!
    @IBOutlet private weak var activityImgFood: UIActivityIndicatorView!
    
    private var homeDetailModel: HomeDetailModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction private func btnExit(_ sender : Any?) {
        homeDetailModel.exitController()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeDetailViewController {
    
    private func loadData() {
        homeDetailModel.loadFood()
        homeDetailModel.successFood = { [weak self] objFood in
            guard let self = self else { return }
            self.lblTitle.text = objFood.name
            self.lblDescription.text = objFood.description
            self.lblTagline.text = objFood.tagline
            self.activityImgFood.startAnimating()
            self.imgFood.downloadImageView(url: objFood.image ?? "") { [weak self] image in
                guard let self = self else { return }
                self.activityImgFood.stopAnimating()
                self.imgFood.image = image
            }
        }
    }

    func didRecieveDataFood(objFood: FoodBE) {
        self.homeDetailModel = HomeDetailModel(
            toController: self,
            obj: objFood
        )
    }
}
