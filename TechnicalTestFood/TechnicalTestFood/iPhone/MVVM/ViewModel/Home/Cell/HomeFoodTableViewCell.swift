//
//  HomeFoodTableViewCell.swift
//  TechnicalTestFood
//
//  Created by Alexander Ynoñan H. on 3/01/23.
//

import UIKit

class HomeFoodTableViewCell: UITableViewCell {

    @IBOutlet weak private var lblName: UILabel!
    @IBOutlet weak private var lblDescription: UILabel!
    @IBOutlet weak private var imgFood: UIImageView!
    @IBOutlet weak private var activityImgaeFood: UIActivityIndicatorView!

    var objFood: FoodBE! {
        didSet {
            lblName.text = objFood.name
            lblDescription.text = objFood.description
            activityImgaeFood.startAnimating()
            imgFood.downloadImageView(url: objFood.image ?? "") { [weak self] image in
                guard let self = self else { return }
                self.activityImgaeFood.stopAnimating()
                self.imgFood.image = image
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
