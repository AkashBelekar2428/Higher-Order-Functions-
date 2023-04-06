//
//  MobileResponse.swift
//  AchiveGolas
//
//  Created by Akash Belekar on 04/04/23.
//

import Foundation
import ObjectMapper
class MobileResponse: Mappable{
    var newspaper:[NewspaperResponse]?
    required init?(map: ObjectMapper.Map) {
        
    }
    func mapping(map: ObjectMapper.Map) {
        newspaper <- map["newspapers"]
    }
    
}
class NewspaperResponse:Mappable{
    var lccn:String?
    var url:String?
    var state:String?
    var title:String?
    var isSelected = false
    
    required init?(map: ObjectMapper.Map) {
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        lccn <- map["lccn"]
        url <- map["url"]
        state <- map["state"]
        title <- map["title"]
    }
    init(){
        
    }
    
    
}
