//
//  SplashViewController.swift
//  TechnicalTestFood
//
//  Created by Alexander Ynoñan H. on 3/01/23.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak private var loadActivity : UIActivityIndicatorView!
    
    private var modelSplash : SplashModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadModel()
        // Do any additional setup after loading the view.
    }

}

extension SplashViewController {
    
    private func loadModel() {
        loadActivity.startAnimating()
        modelSplash = SplashModel(toController: self)
        
        modelSplash.succesSplashToController = { [weak self] in
            guard let self = self else { return }
            self.loadActivity.stopAnimating()
        }
    }
}
