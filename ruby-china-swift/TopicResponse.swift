//
//  TopicResponse.swift
//  ruby-china-swift
//
//  Created by kaka on 16/2/20.
//  Copyright © 2016年 kaka. All rights reserved.
//

import ObjectMapper

class TopicResponse: Mappable{
    
    var topic: Topic?
    var meta: TopicDetailMeta?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        topic <- map["topic"]
        meta  <- map["meta"]
    }
    
}
