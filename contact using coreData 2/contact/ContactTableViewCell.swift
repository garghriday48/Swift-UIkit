//
//  ContactTableViewCell.swift
//  contact
//
//  Created by Pragath on 02/03/23.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var nameTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
