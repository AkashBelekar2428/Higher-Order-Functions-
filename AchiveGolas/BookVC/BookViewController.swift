//
//  BookViewController.swift
//  AchiveGolas
//
//  Created by Akash Belekar on 04/04/23.
//

import UIKit
import Alamofire
import ObjectMapper
import SDWebImage
protocol bDataPassDelegate{
    func bookData(data:DataResponse,index:Int)
}
class BookViewController: UIViewController {
    @IBOutlet weak var bookTbl:UITableView!
    
    var BookDataModel:[DataResponse] = []
    var bookData:[BookData] = []
    var bookDelegate:bDataPassDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        bookTbl.register(UINib(nibName: "BookTVC", bundle: nil), forCellReuseIdentifier: "BookTVC")
        bookTbl.dataSource = self
        bookTbl.delegate = self
        bookTbl.separatorStyle = .none
        getApi()
    }
    
    private func getApi(){
        let url = "https://reqres.in/api/users?page=2"
        
        Alamofire.request(url).responseJSON { response in
            print("response",response)
            
            switch response.result{
            case .success(_):
                if let result = response.result.value{
                    
                    _ = result as! NSDictionary
                    let str = String(data: response.data!, encoding: String.Encoding.utf8)!
                    let objData = Mapper<BookModel>().map(JSONString: str)
                  //  print("objData",objData?.toJSON())
                    
                    self.BookDataModel = (objData?.data)!
                    
                    DispatchQueue.main.async {
                        self.bookTbl.reloadData()
                    }
                  
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }

    @IBAction func Tapped(_ sender: UIButton) {
        var bookArray = BookDataModel.map({$0.firtstName!})
        print("bookArray",bookArray)
        
        for arr in bookArray{
            var data = BookData()
            var objData = BookDataModel.filter({$0.firtstName == arr})
            data.name = arr
            data.list = objData
            bookData.append(data)
        }
        var obj = bookData.filter({$0.name == "Michael"})
        BookDataModel = obj[0].list!
        self.bookTbl.reloadData()
        
    }
    @objc func tapped(_ tap:UITapGestureRecognizer){
        let url = self.BookDataModel[tap.view?.tag ?? 0].email
        
        if let urls = URL(string: url!){
            UIApplication.shared.open(urls)
            //not open url because of its simple string not a json file..
        }
    }
    
}
extension BookViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BookDataModel.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookTVC", for: indexPath) as! BookTVC
        cell.avatarImg.sd_setImage(with: URL(string: "\(BookDataModel[indexPath.row].avatar ?? "")"), placeholderImage: UIImage(systemName: "homekit"))
        cell.selectionStyle = .none
        cell.emailLbl.isUserInteractionEnabled = true
        cell.emailLbl.tag = indexPath.row
        cell.emailLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped(_ :))))
        cell.firstNameLbl.text = BookDataModel[indexPath.row].firtstName ?? ""
        cell.lastNameLbl.text = BookDataModel[indexPath.row].lastName ?? ""
        cell.emailLbl.text = BookDataModel[indexPath.row].email ?? ""
        if BookDataModel[indexPath.row].isSelected == true{
            cell.backgroundColor = .cyan
            
        }else{
            cell.backgroundColor = .white
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bookDelegate?.bookData(data: BookDataModel[indexPath.row], index: indexPath.row)
    }
}
