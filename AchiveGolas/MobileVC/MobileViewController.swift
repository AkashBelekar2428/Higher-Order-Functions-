//
//  MobileViewController.swift
//  AchiveGolas
//
//  Created by Akash Belekar on 04/04/23.
//

import UIKit
import Alamofire
import ObjectMapper
protocol mobileDataPassDelegate{
    func mobileData(data:NewspaperResponse,index:Int)
}

class MobileViewController: UIViewController {
    @IBOutlet weak var mobileTbl:UITableView!
  
    var mobileModel: [NewspaperResponse] = []
    var mobileData: [MobileData] = []
    var stateData: [StateDataModel] = []
    var emptyArray = [String]()
    var nillArray = [String]()
    var delegate:mobileDataPassDelegate?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        mobileTbl.register(UINib(nibName: "MobileTVC", bundle: nil), forCellReuseIdentifier: "MobileTVC")
        mobileTbl.dataSource = self
        mobileTbl.delegate = self
        getNewsPaperApi()
        
    }
    
    private func getNewsPaperApi(){
        let url = "https://chroniclingamerica.loc.gov/newspapers.json"
        
        Alamofire.request(url).responseJSON { response in
            print(response)
            
            switch response.result{
            case .success(_):
                
                if let result = response.result.value{
                    let JSON = result as! NSDictionary
                    let str = String(data: response.data!, encoding: String.Encoding.utf8)!
                    let objData = Mapper<MobileResponse>().map(JSONString: str)
                    
                    // print("objData",objData?.toJSON())
                    
                    self.mobileModel = (objData?.newspaper)!
                   
                    
                    DispatchQueue.main.async {
                        self.mobileTbl.reloadData()
                    }
                    
                    let stateArray = self.mobileModel.map({$0.state})
                    //  print("stateArray",stateArray)
                    
                    //Sorting stateArray
                    for arr in stateArray{
                        if self.emptyArray.count == 0{
                            self.emptyArray.append(arr!)
                        }else{
                            if self.emptyArray.contains(arr!) == false{
                                self.emptyArray.append(arr!)
                            }
                        }
                    }
                    print("emptyArray",self.emptyArray)
                    for ar in self.emptyArray{
                        let data = MobileData()
                        let emptyarrData = self.mobileModel.filter({$0.state == ar})
                        data.stateList = emptyarrData
                        data.stateName = ar
                        self.mobileData.append(data)
                    
                    }
                    
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func TapBtnClicked(_ sender: UIButton) {
        print("btn")
        
        if mobileData != nil{
            var mapMobileData = mobileModel.map({$0.state})
//            print("arr",arr)
            
            for arr in mapMobileData{
                
                if  nillArray.count == 0{
                    nillArray.append(arr!)
                }else{
                    if nillArray.contains(arr!) == false{
                        nillArray.append(arr!)
                    }
                }
            }
//            print("emptyArray",emptyArray)
            
            for arrData in nillArray{
                var data = StateDataModel()
                var sortArray = mobileModel.filter({$0.state == arrData})
                data.nameOfState = arrData
                data.listOfState = sortArray
                stateData.append(data)
            }
            var arrayData = stateData.filter({$0.nameOfState == "Arkansas"})
            print("arrayData",arrayData)
            mobileModel = arrayData[0].listOfState!
            self.mobileTbl.reloadData()
        }
        
        
    }
    @objc func tapClicked(_ tap:UITapGestureRecognizer){
        
        let url = self.mobileModel[tap.view?.tag ?? 0].url
        if let urls = URL(string: url!){
            UIApplication.shared.open(urls)
        }
    }
}
extension MobileViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mobileModel.count
    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return stateData.count
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MobileTVC", for: indexPath) as! MobileTVC
        cell.urlLbl.textColor = .blue
        cell.selectionStyle = .none
        cell.urlLbl.isUserInteractionEnabled = true
        cell.urlLbl.tag = indexPath.row
        cell.urlLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapClicked(_ :))))
        cell.lccnLbl.text = "lccn: \(mobileModel[indexPath.row].lccn ?? "")"
        cell.urlLbl.text = "url: \(mobileModel[indexPath.row].url ?? "")"
        cell.stateLbl.text = "State: \(self.mobileModel[indexPath.row].state ?? "")"
        cell.titleLbl.text = "Title: \(mobileModel[indexPath.row].title ?? "")"
        if mobileModel[indexPath.row].isSelected == true{
            cell.backgroundColor = .orange
        }else{
            cell.backgroundColor = .white
        }
//        if mobileData[indexPath.section].isSelected == true{
//            cell.backgroundColor = .orange
//        }else{
//            cell.backgroundColor = .white
//        }
        return cell
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return stateData[section].nameOfState
//    }
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        view.tintColor = .orange
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // single selection logic
//        for obj in mobileData{
//            obj.isSelected = false
//        }
//        mobileData[indexPath.row].isSelected = true
        
        //multiple selection
//        mobileData[indexPath.row].isSelected =  !mobileData[indexPath.row].isSelected
       // mobileTbl.reloadData()
        
        delegate?.mobileData(data: mobileModel[indexPath.row],index: indexPath.row)
    }
    
    
}
