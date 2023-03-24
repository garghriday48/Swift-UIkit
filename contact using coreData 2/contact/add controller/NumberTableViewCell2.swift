//
//  NumberTableViewCell2.swift
//  contact
//
//  Created by Pragath on 02/03/23.
//

import UIKit

class NumberTableViewCell2: UITableViewCell {

    @IBOutlet weak var typeOfNum: UILabel!
    @IBOutlet weak var numberTextField:
    UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
