//
//  UserResponse.swift
//  AchiveGolas
//
//  Created by Akash Belekar on 06/04/23.
//

import Foundation
import ObjectMapper

class UserResponse:Mappable{
    var user:[UserDataResponse]?
    required init?(map: ObjectMapper.Map) {
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        user <- map["users"]
    }
}
class UserDataResponse:Mappable{
    var firstName:String?
    var age:Int?
    var address:AddressResponse?
    var isSelected = false
    
    required init?(map: ObjectMapper.Map) {
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        firstName <- map["firstName"]
        age <- map["age"]
        address <- map["address"]
        
        
    }
    init(){
        
    }
}
class AddressResponse:Mappable{
    var state:String?
    required init?(map: ObjectMapper.Map) {
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        state <- map["state"]
    }
    
    
}
