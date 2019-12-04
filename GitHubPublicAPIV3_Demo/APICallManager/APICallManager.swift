//
//  APICallManager.swift
//  GitHubPublicAPIV3_Demo
//
//  Created by Ravi Parmar on 28/11/19.
//  Copyright © 2019 Ravi Parmar. All rights reserved.
//

import UIKit
import Alamofire


/// Response Handler
protocol APICallManagerCallback :NSObject{
    func apiCallManagerSuccessResponded(dictResponse:[String:Any])
    func apiCallManagerFailedResponse(error:Error)
}


let baseURL = "https://api.github.com/"
let repoSearchPath = "search/repositories?q="
let language = "language:"
let page = "&page="
let itemsPerPage = 25
let per_page = "&per_page=\(itemsPerPage)"





class APICallManager: NSObject {
    static let singletonInstance = APICallManager()
    
    //delegate for call back
    weak var responseHandler: APICallManagerCallback?
    
   fileprivate func apiCallGET(request:Any) {
        let todosEndpoint = formUrl(request: request)
        print(todosEndpoint)
            Alamofire.request(todosEndpoint, method: .get, parameters: nil, encoding: JSONEncoding.default)
        .responseJSON { response in
            guard response.result.isSuccess,
                 let _ = response.result.value else {
                    self.responseHandler?.apiCallManagerFailedResponse(error: response.error!)
                    return
            }
            self.handleResponseData(data: response.data!)
            }
    }
    
    /// for Request URL Dynamically
    func formUrl(request: Any) -> String {
        var finalURL  = String()
        switch request {
        case is APIRequestUserList:
           finalURL = (request as! APIRequestUserList).url
            break
        case is APIRequestRepoList:
            finalURL = baseURL + repoSearchPath + language + "\((request as! APIRequestRepoList).language)" + per_page + page + "\((request as! APIRequestRepoList).pageNo)"
            break
        default:
            break
        }
        return finalURL
    }
    
    /// Handles Response Data
    /// - Parameter data: Response.data
    func  handleResponseData(data : Data){
           //array of Key Value
           var dictData:[String: Any]!
           do{
               dictData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String : Any]
               if dictData == nil {
                   //array of dictionary
                    let newDictData:[Dictionary<String,Any>]!
                   do{
                       newDictData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [Dictionary<String,Any>]
                       dictData = ["items" : newDictData as Any]
                   }
                   catch{
                       handleDataParsingIssue()
                   }
               }
               if dictData != nil {
                   self.responseHandler?.apiCallManagerSuccessResponded(dictResponse: dictData)
               }else{
                  handleDataParsingIssue()
               }
           }
           catch{
               handleDataParsingIssue()
           }
       }
       
        // Case: Couldn't parse the response
       func handleDataParsingIssue() {
           self.responseHandler?.apiCallManagerFailedResponse(error: DataParsingError.couldNotParseData)
       }
    
    
    
    
    /// Customize Params If Needed
    ///Also we dont directly expose apiCallGET to all classes as it can be usefull when developing on large scale
    func apiCallGetUserList(params:APIRequestUserList){
        apiCallGET(request: params)
    }
    func apiCallGetAllSwiftRepo(params:APIRequestRepoList){
        apiCallGET(request: params)
    }
    
    
   
    
    
    
    /*
   func getRequestAPICall( pageNo : Int)  {
          let todosEndpoint: String = baseURL + repoSearchPath+"?q=language:swift&order=desc&per_page=25&page="  + "\(pageNo)"
          print(todosEndpoint)
              Alamofire.request(todosEndpoint, method: .get, parameters: nil, encoding: JSONEncoding.default)
          .responseJSON { response in
              guard response.result.isSuccess,
                   let _ = response.result.value else {
                      self.responseHandler?.apiCallManagerFailedResponse(error: response.error!)
                      return
              }
              self.handleResponseData(data: response.data!)
              }
          }
      
          func getUserList(owner: String,repoName: String, isContributor : Bool)  {
              var todosEndpoint = baseURL + "repos/" + "vsouza" + "/" + "awesome-ios/"
              
              if isContributor {
                  todosEndpoint = todosEndpoint + "contributors"
              }else{
                  todosEndpoint = todosEndpoint + "stargazers"
              }
              print(todosEndpoint)
                  Alamofire.request(todosEndpoint, method: .get, parameters: nil, encoding: JSONEncoding.default)
              .responseJSON { response in
                  guard response.result.isSuccess,
                       let _ = response.result.value else {
                          self.responseHandler?.apiCallManagerFailedResponse(error: response.error!)
                          return
                  }
                   self.handleResponseData(data: response.data!)
                  }
        }*/
}
