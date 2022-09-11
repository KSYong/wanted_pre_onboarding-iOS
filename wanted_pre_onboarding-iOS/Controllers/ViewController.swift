//
//  ViewController.swift
//  wanted_pre_onboarding-iOS
//
//  Created by SEUNGYONG KWON on 2022/09/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weatherTableView: UITableView!
    
    var networkManager = NetworkManager.shared
    var dataManager = DataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }


}



