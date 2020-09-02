//
//  SignupVC.swift
//  Edutab
//
//  Created by Chirag Bhojani on 8/26/20.
//  Copyright © 2020 Chirag Bhojani. All rights reserved.
//

import UIKit
import RxSwift

class SignupVC: BaseVC {
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtPincode: UITextField!
    @IBOutlet weak var btnCheckMark: UIButton!
    @IBOutlet weak var btnTerms: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    var isSelected = Bool()
    
    var viewModel: SignUpViewModel = SignUpViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isSelected = false
        
        self.txtFirstName.rx.text
        .orEmpty
        .bind(to: viewModel.firstName)
        .disposed(by: disposeBag)
        
        self.txtLastName.rx.text
        .orEmpty
        .bind(to: viewModel.lastName)
        .disposed(by: disposeBag)
        
        self.txtMobileNumber.rx.text
        .orEmpty
        .bind(to: viewModel.mobileNumber)
        .disposed(by: disposeBag)
        
        self.txtEmail.rx.text
        .orEmpty
        .bind(to: viewModel.email)
        .disposed(by: disposeBag)
        
        self.txtPassword.rx.text
        .orEmpty
        .bind(to: viewModel.password)
        .disposed(by: disposeBag)
        
        self.txtConfirmPassword.rx.text
        .orEmpty
        .bind(to: viewModel.confirmPassword)
        .disposed(by: disposeBag)
        
        self.txtAddress.rx.text
        .orEmpty
        .bind(to: viewModel.address)
        .disposed(by: disposeBag)
        
        self.txtState.rx.text
        .orEmpty
        .bind(to: viewModel.state)
        .disposed(by: disposeBag)
        
        self.txtCity.rx.text
        .orEmpty
        .bind(to: viewModel.city)
        .disposed(by: disposeBag)
        
        self.txtPincode.rx.text
        .orEmpty
        .bind(to: viewModel.pincode)
        .disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnCheckMarkClick(_ sender: UIButton) {
        if isSelected {
            isSelected = false
            btnCheckMark.setImage(UIImage(named: "icoUncheck"), for: .normal)
        } else {
            isSelected = true
            btnCheckMark.setImage(UIImage(named: "icoCheck"), for: .normal)
        }
    }
    
    @IBAction func btnBackClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTermsClick(_ sender: UIButton) {
        self.viewModel.apiTermsAndCondiction(dicParam: [:]) { (isSuccess, dicResponse) in
            
        }
    }
    
    @IBAction func btnSignUpClick(_ sender: UIButton) {
        if self.viewModel.fieldValidation() {
            if isSelected {
                var signupRequest: SignUpRequest = SignUpRequest()
                signupRequest.name = "\(self.viewModel.firstName.value) " + self.viewModel.lastName.value
                signupRequest.mobile = self.viewModel.mobileNumber.value
                signupRequest.email = self.viewModel.email.value
                signupRequest.password = self.viewModel.password.value
                signupRequest.address = self.viewModel.address.value
                signupRequest.city = self.viewModel.city.value
                signupRequest.state = self.viewModel.state.value
                signupRequest.pincode = self.viewModel.pincode.value
                signupRequest.device_token = "123123"
                self.viewModel.apiRegistration(dicParam: signupRequest.dictionary) { (isSuccess, dicResponse) in
                    if isSuccess! {
                        let mobileVerification = Storyboard.main.storyboard().instantiateViewController(withIdentifier: Identifier.mobileVerification.rawValue) as! MobileVerificationVC
                        self.navigationController?.pushViewController(mobileVerification, animated: true)
                    }
                }
            } else {
                SnackBar.show(strMessage: ErrorMesssages.PrivacyPolicy, type: .negative)
            }
        }
    }
}
