//
//  ViewController.swift
//  Edutab
//
//  Created by Chirag Bhojani on 8/26/20.
//  Copyright © 2020 Chirag Bhojani. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField
import RxSwift

class ViewController: BaseVC {
    
    @IBOutlet weak var txtMobileNumber: JVFloatLabeledTextField!
    @IBOutlet weak var txtPassword: JVFloatLabeledTextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    
    var viewModel: LoginViewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtMobileNumber.rx.text
        .orEmpty
        .bind(to: viewModel.mobileNumber)
        .disposed(by: disposeBag)
        
        self.txtPassword.rx.text
        .orEmpty
        .bind(to: viewModel.password)
        .disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnLoginClick(_ sender: UIButton) {
        var loginRequest: LoginRequest = LoginRequest()
        loginRequest.username = self.viewModel.mobileNumber.value
        loginRequest.password = self.viewModel.password.value
        
        if self.viewModel.fieldValidation() {
            self.viewModel.apiLogin(dicParam: loginRequest.dictionary) { (isSuccess, response) in
                AppPrefsManager.sharedInstance.setUserObj(obj: response.dictionary as NSDictionary)
                if response?.mobile_verified == false {
                    let mobileVerification = Storyboard.main.storyboard().instantiateViewController(withIdentifier: Identifier.mobileVerification.rawValue) as! MobileVerificationVC
                    self.navigationController?.pushViewController(mobileVerification, animated: true)
                } else {
                    let home = Storyboard.main.storyboard().instantiateViewController(withIdentifier: Identifier.home.rawValue) as! HomeVC
                    self.navigationController?.pushViewController(home, animated: true)
                }
            }
        }
    }
    
    @IBAction func btnSignUpClick(_ sender: UIButton) {
        let register = Storyboard.main.storyboard().instantiateViewController(withIdentifier: Identifier.register.rawValue) as! SignupVC
        self.navigationController?.pushViewController(register, animated: true)
    }
    
    @IBAction func btnForgotPinClick(_ sender: UIButton) {
        let register = Storyboard.main.storyboard().instantiateViewController(withIdentifier: Identifier.forgotPin.rawValue) as! ForgotPinVC
        self.navigationController?.pushViewController(register, animated: true)
    }
}

