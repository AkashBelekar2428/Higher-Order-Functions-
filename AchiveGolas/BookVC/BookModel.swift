//
//  BookModel.swift
//  AchiveGolas
//
//  Created by Akash Belekar on 05/04/23.
//

import Foundation
import ObjectMapper

class BookModel:Mappable{
    var data:[DataResponse]?
    required init?(map: ObjectMapper.Map) {
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        data <- map["data"]
    }
}
class DataResponse:Mappable{
    var email:String?
    var firtstName:String?
    var lastName:String?
    var avatar:String?
    var isSelected = false
    required init?(map: ObjectMapper.Map) {
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        email <- map["email"]
        firtstName <- map["first_name"]
        lastName <- map["last_name"]
        avatar <- map["avatar"]
    }
    init(){
        
    }
}
