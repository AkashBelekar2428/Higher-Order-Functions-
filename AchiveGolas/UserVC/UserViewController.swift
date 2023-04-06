//
//  UserViewController.swift
//  AchiveGolas
//
//  Created by Akash Belekar on 06/04/23.
//

import UIKit
import Alamofire
import ObjectMapper
protocol userDataDelegate{
    func userDataPAss(data:UserDataResponse,index:Int)
}

class UserViewController: UIViewController {
    @IBOutlet weak var userTbl:UITableView!
    
    var userModel:[UserDataResponse] = []
    var emptyArr = [String]()
    var userDataModel:[UserData] = []
    var userDelegate:userDataDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        userTbl.register(UINib(nibName: "UserTVC", bundle: nil), forCellReuseIdentifier: "UserTVC")
        userTbl.dataSource = self
        userTbl.delegate = self
        getUserApi()
    }
    private func getUserApi(){
        let url = "https://dummyjson.com/users"
        
        Alamofire.request(url).responseJSON { response in
//            print("response",response)
            switch response.result{
            case .success(_):
                if let result = response.result.value{
                    let JSON = result as! NSDictionary
                    let str = String(data: response.data!, encoding: String.Encoding.utf8)!
                    let objData = Mapper<UserResponse>().map(JSONString: str)
                  //  print("objData",objData?.toJSON())
                    
                    self.userModel = (objData?.user)!
                    DispatchQueue.main.async {
                        self.userTbl.reloadData()
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
        
    }
    @IBAction func tap(_ sender: UIButton) {
        // maping data
        var userArray = self.userModel.map({$0.address?.state!})
       // print("userArray",userArray)
        
        //sorting data
        
        for ar in userArray{
            if self.emptyArr.count == 0{
                self.emptyArr.append(ar!)
            }else{
                if self.emptyArr.contains(ar!) == false{
                    self.emptyArr.append(ar!)
                }
            }
                
        }
      //  print("emptyArr",self.emptyArr)
        for arr in userArray{
            var data = UserData()
            var userData = self.userModel.filter({$0.address?.state == arr})
            data.nameOfState = arr
            data.list = userData
            self.userDataModel.append(data)
        }
        var userAr = userDataModel.filter({$0.nameOfState == "TN"})
        self.userModel = userAr[0].list!
        self.userTbl.reloadData()

    }
}
extension UserViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTVC", for: indexPath) as! UserTVC
        cell.nameLbl.text = "Name: \(userModel[indexPath.row].firstName ?? "")"
        cell.ageLbl.text = "Age: \(String(userModel[indexPath.row].age ?? 0))"
        cell.stateLbl.text = "Sate: \(userModel[indexPath.row].address?.state ?? "")"
        if userModel[indexPath.row].isSelected == true{
            cell.backgroundColor = .blue
        }
        else{
            cell.backgroundColor = .white
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userDelegate?.userDataPAss(data: userModel[indexPath.row],index: indexPath.row)
        let vc = UserDetailsViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}
