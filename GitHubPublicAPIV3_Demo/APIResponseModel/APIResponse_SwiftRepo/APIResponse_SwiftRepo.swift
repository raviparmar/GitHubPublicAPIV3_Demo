//
//  APIResponse_SwiftRepo.swift
//  GitHubPublicAPIV3_Demo
//
//  Created by Ravi Parmar on 29/11/19.
//  Copyright © 2019 Ravi Parmar. All rights reserved.
//

import UIKit

class APIResponse_SwiftRepo: NSObject {
    var name:String!
    var full_name:String!
    var size:String!
    var forksCount:String!
    var contributors_url:String!
    var stargazers_url:String!

     static func modelListFrom(dictData:[String:Any]) -> [APIResponse_SwiftRepo]?{
         guard let arrData = dictData["items"] as? [[String: Any]] else{
             return nil
         }
         var mArrModel = [APIResponse_SwiftRepo]()
         for dictAlert in arrData {
             
             let model = APIResponse_SwiftRepo()
             model.name = "\(dictAlert["name"]!)"
             model.full_name = "\(dictAlert["full_name"]!)"
             model.size = "\(dictAlert["size"]!)"
             model.stargazers_url = "\(dictAlert["stargazers_url"]!)"
             model.forksCount = "\(dictAlert["forks_count"]!)"
             model.contributors_url = "\(dictAlert["contributors_url"]!)"
             mArrModel.append(model)
         }
         return mArrModel
     }
}
