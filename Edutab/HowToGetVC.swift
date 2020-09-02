//
//  HowToGetVC.swift
//  Edutab
//
//  Created by Chirag Bhojani on 8/27/20.
//  Copyright © 2020 Chirag Bhojani. All rights reserved.
//

import UIKit

class HowToGetVC: BaseVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
}
