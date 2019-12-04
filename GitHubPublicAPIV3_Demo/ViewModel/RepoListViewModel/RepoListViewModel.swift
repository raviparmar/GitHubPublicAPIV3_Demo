//
//  RepoListViewModel.swift
//  GitHubPublicAPIV3_Demo
//
//  Created by Ravi Parmar on 04/12/19.
//  Copyright © 2019 Ravi Parmar. All rights reserved.
//

import UIKit

struct RepoListViewModel {
    let name:String
    let full_name:String
    let size:String
    let forksCount:String
    let contributors_url:String
    let stargazers_url:String
    
    let titleColor = Constants.titleColor
    let subTitleColor = Constants.subTitleColor
    
    let cellSelectionStyle = UITableViewCell.SelectionStyle.none

    //Dependency Injection (DI)
    init(apiResponse_SwiftRepo : APIResponse_SwiftRepo){
        self.name = apiResponse_SwiftRepo.name
        self.full_name = apiResponse_SwiftRepo.full_name
        self.size = apiResponse_SwiftRepo.size
        self.forksCount = apiResponse_SwiftRepo.forksCount
        self.contributors_url = apiResponse_SwiftRepo.contributors_url
        self.stargazers_url = apiResponse_SwiftRepo.stargazers_url
    }
}
