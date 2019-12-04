//
//  GitHubPublicAPIV3_DemoTests.swift
//  GitHubPublicAPIV3_DemoTests
//
//  Created by Ravi Parmar on 04/12/19.
//  Copyright © 2019 Ravi Parmar. All rights reserved.
//

import XCTest
@testable import GitHubPublicAPIV3_Demo

class GitHubPublicAPIV3_DemoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testRepoListModel(){
        
        //DUMMY model from data received from API
        let data = APIResponse_SwiftRepo()
        data.name = "Material"
        data.full_name = "CosmicMind/Material"
        data.size = "34053"
        data.forksCount = "1236"
        data.contributors_url = "https://api.github.com/repos/CosmicMind/Material/contributors"
        data.stargazers_url = "https://api.github.com/repos/CosmicMind/Material/stargazers"
        
        
        
        //Dummy ViewModel for Repo List View
        let repoViewModel = RepoListViewModel(apiResponse_SwiftRepo: data)
        
        XCTAssertEqual(data.name, repoViewModel.name)
        
        XCTAssertEqual(Constants.titleColor, repoViewModel.titleColor)  
    }
    
    func testUserListModel(){
           
           //DUMMY model from data received from API
           let data = APIResponse_UserList()
           data.name = "test Name"
           data.avatar_url = "https://avatars2.githubusercontent.com/u/3121413?v=4"
           //Dummy ViewModel for Repo List View
           let repoViewModel = UserListViewModel(apiResponse_UserList: data)
           XCTAssertEqual(data.name, repoViewModel.name)
           
       }

}
