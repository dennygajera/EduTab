//
//  MobileVerificationViewModel.swift
//  Edutab
//
//  Created by Chirag Bhojani on 8/28/20.
//  Copyright © 2020 Chirag Bhojani. All rights reserved.
//

import UIKit
import RxSwift

struct MobileVerificationViewModel {
//    checkOTP
//
    
    let mobileNumber = Variable<String>("")
    
    func fieldValidation() -> Bool {
        if mobileNumber.value.isEmpty {
            SnackBar.show(strMessage: ErrorMesssages.emptyPhone, type: .negative)
            return false
        } else {
            return true
        }
    }
    
    func apiCheckOTP(dicParam: [String: Any], completion :@escaping (_ isSucess : Bool?,_ receivedData: LoginUserData?) -> Void) {
        ServiceManager.sharedInstance.postRequest(parameterDict: dicParam, URL: API.checkOTP.URL) { (dicResponse, error) in
            do {
                if dicResponse != nil {
                    completion(true,try JSONDecoder().decode(LoginUserData.self, from: (dicResponse!.dataReturn(isParseDirect: false))!))
                } else {
                    completion(false, nil)
                }
            }
            catch let err {
                print("Err", err)
                completion(false,nil)
            }
        }
    }
    
    
    func apiForgotPassword(dicParam: [String: Any], completion :@escaping (_ isSucess : Bool?,_ receivedData: NSDictionary?) -> Void) {
        ServiceManager.sharedInstance.postRequest(parameterDict: dicParam, URL: API.forgotpassword.URL) { (dicResponse, error) in
            do {
                if dicResponse != nil {
                    completion(true, dicResponse)
                } else {
                    completion(false, nil)
                }
            }
        }
    }
    
    func apiChangePassword(dicParam: [String: Any], completion :@escaping (_ isSucess : Bool?,_ receivedData: NSDictionary?) -> Void) {
        ServiceManager.sharedInstance.postRequest(parameterDict: dicParam, URL: API.changePassword.URL) { (dicResponse, error) in
            do {
                if dicResponse != nil {
                    completion(true, dicResponse)
                } else {
                    completion(false, nil)
                }
            }
        }
    }
}

struct MobileVerificationRequest: Encodable {
    var otp: String?
    var id: String?
}

struct ChangePasswordRequest: Encodable {
    var old_pass: String?
    var new_pass: String?
}

struct ForgotPinRequest: Encodable {
    var mobile: String?
}
