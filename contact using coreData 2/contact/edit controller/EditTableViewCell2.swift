//
//  EditTableViewCell2.swift
//  contact
//
//  Created by Pragath on 03/03/23.
//

import UIKit

class EditTableViewCell2: UITableViewCell {

    
    @IBOutlet weak var editPhoneLabel: UILabel!
    
    @IBOutlet weak var editPhoneTextField: UITextField!
    
    var phoneNum: String?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
