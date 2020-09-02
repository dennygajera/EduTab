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
        self.viewModel.apiDashBoard(dicParam: [:]) { (isSuccess, response) in
            
        }
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
    
    @IBAction func btnBulkInquiryClick (_ sender: UIButton) {
        
    }
    
    @IBAction func btnHelpClick (_ sender: UIButton) {
        
    }
    
    @IBAction func btnSettingClick (_ sender: UIButton) {
        
    }
    
    @IBAction func btnLogOutClick (_ sender: UIButton) {
        
    }
    
    @IBAction func btnTermsClick (_ sender: UIButton) {
        
    }
    
    @IBAction func btnShareWAClick (_ sender: UIButton) {
        
    }


    
}
