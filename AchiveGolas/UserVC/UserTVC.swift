//
//  UserTVC.swift
//  AchiveGolas
//
//  Created by Akash Belekar on 06/04/23.
//

import UIKit

class UserTVC: UITableViewCell {
    @IBOutlet weak var nameLbl:UILabel!
    @IBOutlet weak var ageLbl:UILabel!
    @IBOutlet weak var stateLbl:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
