//
//  BookTVC.swift
//  AchiveGolas
//
//  Created by Akash Belekar on 04/04/23.
//

import UIKit

class BookTVC: UITableViewCell {
    @IBOutlet weak var avatarImg:UIImageView!
    @IBOutlet weak var firstNameLbl:UILabel!
    @IBOutlet weak var lastNameLbl:UILabel!
    @IBOutlet weak var emailLbl:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
