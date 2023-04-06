//
//  UserDetailsViewController.swift
//  AchiveGolas
//
//  Created by Akash Belekar on 06/04/23.
//

import UIKit

protocol colorDelegate{
    func changeBackgorundColor()
}
class UserDetailsViewController: UIViewController,userDelegate {
    
    @IBOutlet weak var stateLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
 
    var obj = UserDataResponse.init()
    var colorDelegate:colorDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        stateLbl.text = obj.address?.state
        ageLbl.text = "\(obj.age ?? 0)"
        nameLbl.text = obj.firstName
        
      
    }
    func dataOfUser(name: String, age: Int, state: String) {
        stateLbl.text = state
        nameLbl.text = name
        ageLbl.text = String(age)
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        colorDelegate?.changeBackgorundColor()
        dismiss(animated: true)
    }
    
    @IBAction func clickbtn(_ sender: UIButton) {
        let vc = HeadBoxViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        present(vc, animated: true)
        
    }
    
}
