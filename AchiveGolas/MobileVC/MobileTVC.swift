//
//  MobileTVC.swift
//  AchiveGolas
//
//  Created by Akash Belekar on 04/04/23.
//

import UIKit

class MobileTVC: UITableViewCell {
    @IBOutlet weak var lccnLbl:UILabel!
    @IBOutlet weak var urlLbl:UILabel!
    @IBOutlet weak var stateLbl:UILabel!
    @IBOutlet weak var titleLbl:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
