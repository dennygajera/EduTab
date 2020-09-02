//
//  HomeVC.swift
//  Edutab
//
//  Created by Chirag Bhojani on 8/27/20.
//  Copyright © 2020 Chirag Bhojani. All rights reserved.
//

import UIKit

class HomeVC: BaseVC {
    
    
    var viewModel: HomeViewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftImg = UIImage(named: "icoBack")
        let rightImg = UIImage(named: "icoUser")
        self.setNavigationBar(title: "", titleImage: nil, leftImage: leftImg, rightImage: rightImg, leftTitle: nil, rightTitle: nil, isLeft: true, isRight: true, isLeftMenu: false, isRightMenu: false, bgColor: .white, textColor: .white, isStatusBarSame: true, leftClick: { (sender) in
            
        }) { (sender) in
            AppPrefsManager.sharedInstance.removeDataFromPreference(key: AppPrefsManager.sharedInstance.USER)
            let login = Storyboard.main.storyboard().instantiateViewController(withIdentifier: Identifier.ViewController.rawValue) as! ViewController
            self.navigationController?.pushViewController(login, animated: true)
        }
        
        
        self.viewModel.apiDashBoard(dicParam: [:]) { (isSuccess, response) in
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func btnAddChildClick (_ sender: UIButton) {
        let child = Storyboard.main.storyboard().instantiateViewController(withIdentifier: Identifier.child.rawValue) as! ChildVC
        self.navigationController?.pushViewController(child, animated: true)
    }
    
    @IBAction func btnBookYourTabletClick (_ sender: UIButton) {
        
    }
    
    @IBAction func btn360ViewClick (_ sender: UIButton) {
        
    }
    
    @IBAction func btnHowtogetclick (_ sender: UIButton) {
        
    }
    
    @IBAction func btnSettingClick (_ sender: UIButton) {
        
    }
    
    @IBAction func btnMobileClick (_ sender: UIButton) {
        
    }


    
}
