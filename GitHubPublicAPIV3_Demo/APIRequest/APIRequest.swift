//
//  APIRequest.swift
//  GitHubPublicAPIV3_Demo
//
//  Created by Ravi Parmar on 03/12/19.
//  Copyright © 2019 Ravi Parmar. All rights reserved.
//

import UIKit

struct APIRequestRepoList {
    let language : String
    let per_page : Int
    let pageNo : Int
    
    init(language : String,  per_page : Int, pageNo : Int) {
        self.language = language
        self.per_page = per_page
        self.pageNo = pageNo
    }
    
}

struct APIRequestUserList {
    let url : String
    init(url : String) {
        self.url = url
    }
}

