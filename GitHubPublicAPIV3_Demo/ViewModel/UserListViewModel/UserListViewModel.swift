//
//  UserListViewModel.swift
//  GitHubPublicAPIV3_Demo
//
//  Created by Ravi Parmar on 04/12/19.
//  Copyright © 2019 Ravi Parmar. All rights reserved.
//

import UIKit

struct UserListViewModel {
    let name:String
    let avatar_url:String
    
    let titleColor = Constants.titleColor
    let cellSelectionStyle = UITableViewCell.SelectionStyle.none

    //Dependency Injection (DI)
    init(apiResponse_UserList : APIResponse_UserList) {
        self.name = apiResponse_UserList.name
        self.avatar_url = apiResponse_UserList.avatar_url
    }
}
