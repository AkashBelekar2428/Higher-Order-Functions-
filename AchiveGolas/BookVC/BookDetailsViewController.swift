//
//  BookDetailsViewController.swift
//  AchiveGolas
//
//  Created by Akash Belekar on 06/04/23.
//

import UIKit
protocol BcolorBackgroundDelegate{
    func backgroundcolorChangeB()
}

class BookDetailsViewController: UIViewController {
    @IBOutlet weak var avatarImg:UIImageView!
    @IBOutlet weak var firstNameLbl:UILabel!
    @IBOutlet weak var lastNameLbl:UILabel!
    @IBOutlet weak var emailLbl:UILabel!
    
    var obj = DataResponse.init()
    var bDelagate:BcolorBackgroundDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarImg.sd_setImage(with: URL(string: "\(obj.avatar ?? "")"), placeholderImage: UIImage(systemName: "homekit"))
        firstNameLbl.text = obj.firtstName
        lastNameLbl.text = obj.lastName
        emailLbl.text = obj.email

    }
    @IBAction func backBtn(){
        bDelagate?.backgroundcolorChangeB()
        dismiss(animated: true)
    }


}
