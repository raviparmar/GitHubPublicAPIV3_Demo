//
//  RepoDetailsViewController.swift
//  GitHubPublicAPIV3_Demo
//
//  Created by Ravi Parmar on 02/12/19.
//  Copyright © 2019 Ravi Parmar. All rights reserved.
//

import UIKit

class RepoDetailsViewController: UIViewController {

    var swiftRepoViewModel : RepoListViewModel?

    
    @IBOutlet weak var vw1: UIView!
    @IBOutlet weak var vw2: UIView!
    @IBOutlet weak var vw3: UIView!
    @IBOutlet weak var vw4: UIView!
    
    @IBOutlet weak var vwCircle1: UIView!
    @IBOutlet weak var vwCircle2: UIView!
    @IBOutlet weak var vwCircle3: UIView!
    @IBOutlet weak var vwCircle4: UIView!

    @IBOutlet weak var lblTitle1: UILabel!
    @IBOutlet weak var lblTitle2: UILabel!
    @IBOutlet weak var lblTitle3: UILabel!
    @IBOutlet weak var lblTitle4: UILabel!

    
    
    
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblForksCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureView()
    }
    
    func configureView() {
        lblSize?.text = swiftRepoViewModel?.size
        lblForksCount?.text = swiftRepoViewModel?.forksCount
        
        vw1.layer.cornerRadius = 7
        vw2.layer.cornerRadius = 7
        vw3.layer.cornerRadius = 7
        vw4.layer.cornerRadius = 7
        
        let cornerRadius = vwCircle1.frame.size.height/2
        
        
        vwCircle1.layer.cornerRadius = cornerRadius
        vwCircle2.layer.cornerRadius = cornerRadius
        vwCircle3.layer.cornerRadius = cornerRadius
        vwCircle4.layer.cornerRadius =  cornerRadius
        
        
        lblTitle1.textColor = Constants.titleColor
        lblTitle2.textColor = Constants.titleColor
        lblTitle3.textColor = Constants.titleColor
        lblTitle4.textColor = Constants.titleColor
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! UserListTableViewController

        if segue.identifier == "showContributors" {
            controller.isContributor = true
        }else if segue.identifier == "showStargazers" {
            controller.isContributor = false
        }
        controller.swiftRepoViewModel = swiftRepoViewModel
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
