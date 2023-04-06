//
//  MobileDetailsViewController.swift
//  AchiveGolas
//
//  Created by Akash Belekar on 06/04/23.
//

import UIKit
protocol mbackgroundchangeDelegate{
    func background()
}

class MobileDetailsViewController: UIViewController {
    @IBOutlet weak var lccnLbl:UILabel!
    @IBOutlet weak var urlLbl:UILabel!
    @IBOutlet weak var stateLbl:UILabel!
    @IBOutlet weak var titleLbl:UILabel!

    var obj = NewspaperResponse.init()
    var mCoolorDelegate:mbackgroundchangeDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        lccnLbl.text = obj.lccn
        urlLbl.text = obj.url
        stateLbl.text = obj.state
        titleLbl.text = obj.title
        
    }
    @IBAction func backBtn(){
        mCoolorDelegate?.background()
        dismiss(animated: true)
    }
    
}
