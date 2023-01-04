//
//  MessageTableViewCell.swift
//  TechnicalTestFood
//
//  Created by Alexander Ynoñan H. on 3/01/23.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak private var lblName: UILabel!

    var message: String! {
        didSet {
            lblName.text = message
        }
    }
}
