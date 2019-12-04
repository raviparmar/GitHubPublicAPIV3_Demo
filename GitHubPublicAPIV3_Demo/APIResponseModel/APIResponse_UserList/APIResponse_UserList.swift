//
//  APIResponse_UserList.swift
//  GitHubPublicAPIV3_Demo
//
//  Created by Ravi Parmar on 02/12/19.
//  Copyright © 2019 Ravi Parmar. All rights reserved.
//

import UIKit

class APIResponse_UserList: NSObject {
    var name:String!
    var avatar_url:String!
    static func modelListFrom(dictData:[String:Any]) -> [APIResponse_UserList]?{
        guard let arrData = dictData["items"] as? [[String: Any]] else{
            return nil
        }
        var mArrModel = [APIResponse_UserList]()
        for dictAlert in arrData {
            let model = APIResponse_UserList()
            
            model.name = "\(dictAlert["login"]!)"
            model.avatar_url = "\(dictAlert["avatar_url"]!)"

            mArrModel.append(model)
        }
        return mArrModel
    }
}
