//
//  HeadBoxViewController.swift
//  AchiveGolas
//
//  Created by Akash Belekar on 06/04/23.
//

import UIKit
protocol userDelegate{
    func dataOfUser(name:String,age:Int,state:String)
}

class HeadBoxViewController: UIViewController{
    var delegate:userDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func changeDataBtnClicked(){
        delegate?.dataOfUser(name: "Mobifilia", age: 10, state: "Kolhapur")
        dismiss(animated: true)
    }

}
