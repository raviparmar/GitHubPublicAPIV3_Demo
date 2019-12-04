//
//  ViewController.swift
//  GitHubPublicAPIV3_Demo
//
//  Created by Ravi Parmar on 26/11/19.
//  Copyright © 2019 Ravi Parmar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var intPageNumber = 0
    var arrTableData = [RepoListViewModel]()

    
    @IBOutlet weak var btnFetch: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        APICallManager.singletonInstance.responseHandler = self
        btnfetchDataPressed(btnFetch)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureView()
    }
    private func configureView(){
        tableView.backgroundColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.title = "Git Swift Repo List"
        btnFetch.layer.cornerRadius = 7
        navigationController?.navigationBar.barTintColor = Constants.titleColor
        self.tableView.tableFooterView = UIView(frame: .zero)
    }

    @IBAction func btnfetchDataPressed(_ sender: UIButton) {
        intPageNumber += 1
        getPublicRepos()

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! RepoDetailsViewController
                controller.swiftRepoViewModel = arrTableData[indexPath.row]
            }
        }
    }
}

extension ViewController : APICallManagerCallback{
    func getPublicRepos() {
        let request = APIRequestRepoList.init(language: "swift", per_page: 25, pageNo: intPageNumber)
        APICallManager.singletonInstance.apiCallGetAllSwiftRepo(params: request)
        activityIndicator.startAnimating()
       }
    
    
    func apiCallManagerSuccessResponded(dictResponse: [String : Any]) {
        activityIndicator.stopAnimating()
       if let arrData = APIResponse_SwiftRepo.modelListFrom(dictData: dictResponse){
       if arrData.isEmpty == false{
        arrTableData.append(contentsOf: arrData.map({return RepoListViewModel(apiResponse_SwiftRepo: $0)}))
        tableView.reloadData()
        }
    }
    }
    
    
    func apiCallManagerFailedResponse(error: Error) {
        print(error.localizedDescription)
        activityIndicator.stopAnimating()

    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrTableData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "customTableViewCell") as! customTableViewCell
        // set the text from the data model
        let repoListViewModel = arrTableData[indexPath.row]
        cell.repoListViewModel = repoListViewModel
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}


class customTableViewCell : UITableViewCell{
    var repoListViewModel : RepoListViewModel!{
        didSet{
            lblName.text = repoListViewModel.name
            lblFullName.text = repoListViewModel.full_name
            lblName.textColor = repoListViewModel.titleColor
            lblFullName.textColor = repoListViewModel.subTitleColor
            selectionStyle = repoListViewModel.cellSelectionStyle
        }
    }
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
}



