//
//  UserListTableViewController.swift
//  GitHubPublicAPIV3_Demo
//
//  Created by Ravi Parmar on 02/12/19.
//  Copyright © 2019 Ravi Parmar. All rights reserved.
//

import UIKit
import Alamofire

class UserListTableViewController: UITableViewController {

    var isContributor = false
    var swiftRepoViewModel : RepoListViewModel?

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var arrTableData = [UserListViewModel]()
    
    
    @IBOutlet var tblUserDetails: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    APICallManager.singletonInstance.responseHandler = self
       configureData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureView()
    }
    
    
    
    func configureView() {
        if isContributor{
            self.title = "Contributors"   
        }else{
            self.title = "Stargazers"
        }
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    func configureData() {
        getUserDetails()
    }

    
    override  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              arrTableData.count
          }
          
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "userDetailListTableViewCell") as! userDetailListTableViewCell
            let userListViewModel = arrTableData[indexPath.row]
            cell.userListViewModel = userListViewModel
            return cell
          }
    
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}



extension UserListTableViewController : APICallManagerCallback{
    func getUserDetails() {
        
        var request : APIRequestUserList
        if isContributor {
            request = APIRequestUserList.init(url: (swiftRepoViewModel?.contributors_url)!)
        }else{
            request = APIRequestUserList.init(url: (swiftRepoViewModel?.stargazers_url)!)
        }
        APICallManager.singletonInstance.apiCallGetUserList(params: request)
        activityIndicator.startAnimating()
       }
    
  
    func apiCallManagerSuccessResponded(dictResponse: [String : Any]) {
        activityIndicator.stopAnimating()
       if let arrData = APIResponse_UserList.modelListFrom(dictData: dictResponse){
       if arrData.isEmpty == false{
            arrTableData.append(contentsOf: arrData.map({return UserListViewModel(apiResponse_UserList: $0)}))
            tblUserDetails.reloadData()
        }
     }
    }
    
    
    func apiCallManagerFailedResponse(error: Error) {
        print(error.localizedDescription)
        activityIndicator.stopAnimating()

    }
}


class userDetailListTableViewCell : UITableViewCell{

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    
    var userListViewModel : UserListViewModel!{
        didSet{
            lblName.text = userListViewModel.name
            lblName.textColor = userListViewModel.titleColor
            imgProfile.layer.cornerRadius = imgProfile.frame.size.width/2
            selectionStyle = userListViewModel.cellSelectionStyle
            
            
            weak var weakSelf = self

            Alamofire.request(userListViewModel.avatar_url, method: .get).response { response in
                      guard let image = UIImage(data:response.data!) else {
                          // Handle error
                          return
                      }
                      let imageData = image.jpegData(compressionQuality: 1.0)
                      weakSelf?.imgProfile.image = UIImage(data : imageData!)
            }
            
            
        }
    }
    
    
    
}


