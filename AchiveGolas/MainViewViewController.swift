//
//  MainViewViewController.swift
//  AchiveGolas
//
//  Created by Akash Belekar on 04/04/23.
//

import UIKit

class MainViewViewController: UIViewController,colorDelegate,userDataDelegate,mobileDataPassDelegate,mbackgroundchangeDelegate,bDataPassDelegate,BcolorBackgroundDelegate{
 
    @IBOutlet weak var backgroundView: UIView!
    var index = 0
    var bookVC = BookViewController()
    var mobileVC = MobileViewController()
    var userVC = UserViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        bookVC = BookViewController.init()
        mobileVC = MobileViewController.init()
        userVC = UserViewController.init()

    }


    @IBAction func segmentBtn(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
            
        case 0 :
            addChild(bookVC)
            let frame = backgroundView.frame
            bookVC.view.frame = frame
            bookVC.bookDelegate = self
            view.addSubview(bookVC.view)
            didMove(toParent: self)
            
        case 1:
            addChild(mobileVC)
            let frame = backgroundView.frame
            mobileVC.view.frame = frame
            mobileVC.delegate = self
            view.addSubview(mobileVC.view)
            didMove(toParent: self)
            
        case 2:
            addChild(userVC)
            let frame = backgroundView.frame
            userVC.view.frame = frame
            userVC.userDelegate = self
            view.addSubview(userVC.view)
            didMove(toParent: self)
            
        default:
            print("no vc")
        }
        
    }
    func changeBackgorundColor() {
        userVC.userModel[self.index].isSelected = true
        userVC.userTbl.reloadData()
    }
  
    func userDataPAss(data: UserDataResponse, index: Int) {
        self.index = index
        let vc = UserDetailsViewController()
        vc.obj = data
        vc.colorDelegate = self
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    func mobileData(data: NewspaperResponse, index: Int) {
        self.index = index
        let vc = MobileDetailsViewController()
        vc.obj = data
        vc.mCoolorDelegate = self
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    func background() {
        mobileVC.mobileModel[self.index].isSelected = true
        self.mobileVC.mobileTbl.reloadData()
    }
  
    func bookData(data: DataResponse, index: Int) {
        self.index = index
        let vc = BookDetailsViewController()
        vc.obj = data
        vc.bDelagate = self
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func backgroundcolorChangeB() {
        bookVC.BookDataModel[self.index].isSelected = true
        self.bookVC.bookTbl.reloadData()
    }
    
    
    
}
