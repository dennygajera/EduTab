//
//  ForgotPinVC.swift
//  Edutab
//
//  Created by Chirag Bhojani on 8/28/20.
//  Copyright © 2020 Chirag Bhojani. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField
import RxSwift

class ForgotPinVC: BaseVC {
    
    @IBOutlet weak var txtMobile: JVFloatLabeledTextField!
    
    var viewModel: MobileVerificationViewModel = MobileVerificationViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtMobile.rx.text
        .orEmpty
        .bind(to: viewModel.mobileNumber)
        .disposed(by: disposeBag)
        
        
    }
    
    @IBAction func btnBackClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func btnSubmitClick(_ sender: UIButton) {
        if self.viewModel.fieldValidation() {
            var forgotPinRequest: ForgotPinRequest = ForgotPinRequest()
            forgotPinRequest.mobile = self.viewModel.mobileNumber.value
            self.viewModel.apiForgotPassword(dicParam: forgotPinRequest.dictionary) { (isSuccess, response) in
                if isSuccess! {
                    let mobileVerification = Storyboard.main.storyboard().instantiateViewController(withIdentifier: Identifier.mobileVerification.rawValue) as! MobileVerificationVC
                    mobileVerification.userId = (response?.value(forKey: "response") as! NSDictionary).value(forKey: "id") as! String
                    mobileVerification.strForm = "Forgot Pin"
                    
                    self.navigationController?.pushViewController(mobileVerification, animated: true)
                }
            }
        }
    }
}
