//
//  MobileVerificationVC.swift
//  Edutab
//
//  Created by iMac on 27/08/20.
//  Copyright © 2020 Chirag Bhojani. All rights reserved.
//

import UIKit
import SVPinView

class MobileVerificationVC: BaseVC {
    @IBOutlet weak var pinView: SVPinView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnResendOTP: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    var forgotPinDialog: ForgotPinDialog!
    var strPin = String()
    var strForm = String()
    var userId = String()
    
    var viewModel: MobileVerificationViewModel = MobileVerificationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pinView.style = .box
        pinView.fieldCornerRadius = 4
        
        
        pinView.didFinishCallback = { [weak self] pin in
            print("The pin entered is \(pin)")
            self!.strPin = pin
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnBackClick (_sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSubmitClick (_sender: UIButton) {
        var mobileVerificationRequest: MobileVerificationRequest = MobileVerificationRequest()
        
        if AppPrefsManager.sharedInstance.isKeyExistInPreference(key: AppPrefsManager.sharedInstance.USER) {
            mobileVerificationRequest.id = AppPrefsManager.sharedInstance.getUserObj()?.id
        } else {
            mobileVerificationRequest.id = userId
        }
        mobileVerificationRequest.otp = self.strPin
        self.viewModel.apiCheckOTP(dicParam: mobileVerificationRequest.dictionary) { (isSuccess, response) in
            if self.strForm == "Forgot Pin" {
                
                AppPrefsManager.sharedInstance.setUserObj(obj: response.dictionary as NSDictionary)
                
                
                self.forgotPinDialog = (Storyboard.main.storyboard().instantiateViewController(withIdentifier: Identifier.ForgotPinDialog.rawValue) as! ForgotPinDialog)
                self.forgotPinDialog.modalPresentationStyle = .overFullScreen
                self.forgotPinDialog.delegate = self
                self.present(self.forgotPinDialog, animated: true, completion: nil)
            } else {
                let home = Storyboard.main.storyboard().instantiateViewController(withIdentifier: Identifier.home.rawValue) as! HomeVC
                self.navigationController?.pushViewController(home, animated: true)
            }
        }
    }
    
    @IBAction func btnResendOTPClick (_sender: UIButton) {
        
    }
    
}

extension MobileVerificationVC: ForgotPinDelegate {
    func saveButtonClickHandler(obj: UIButton) {
        var changePasswordRequest: ChangePasswordRequest = ChangePasswordRequest()
        changePasswordRequest.old_pass = self.forgotPinDialog.txtOldPin.text
        changePasswordRequest.new_pass = self.forgotPinDialog.txtNewPin.text
        
        self.viewModel.apiChangePassword(dicParam: changePasswordRequest.dictionary) { (isSuccess, response) in
            if isSuccess! {
                
                if response?.value(forKey: "success") as! Bool == true {
                    self.delayWithSeconds(2.0) {
                        self.dismiss(animated: true, completion: nil)
                        let home = Storyboard.main.storyboard().instantiateViewController(withIdentifier: Identifier.home.rawValue) as! HomeVC
                        self.navigationController?.pushViewController(home, animated: true)
                    }
                }
            }
        }
    }
    
    func cancelButtonClickHandler(obj: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}




