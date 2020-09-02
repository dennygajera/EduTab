//
//  LoginViewModel.swift
//  Edutab
//
//  Created by Chirag Bhojani on 8/27/20.
//  Copyright © 2020 Chirag Bhojani. All rights reserved.
//

import UIKit
import RxSwift

struct LoginViewModel {
    let mobileNumber = Variable<String>("")
    let password = Variable<String>("")
}

struct LoginRequest: Encodable {
    var username: String?
    var password: String?
}

struct LoginUserData: Codable {
    var token: String?
    var mobile_verified: Bool?
    var id: String?
}

extension LoginViewModel {
    func fieldValidation() -> Bool {
        if mobileNumber.value.isEmpty {
            SnackBar.show(strMessage: ErrorMesssages.emptyPhone, type: .negative)
            return false
        } else {
            if password.value.isEmpty {
                SnackBar.show(strMessage: ErrorMesssages.emptyPassword, type: .negative)
                return false
            } else {
                return true
            }
        }
    }
    
        func apiLogin(dicParam: [String: Any], completion :@escaping (_ isSucess : Bool?,_ receivedData: LoginUserData?) -> Void) {
            ServiceManager.sharedInstance.postRequest(parameterDict: dicParam, URL: API.Login.URL) { (dicResponse, error) in
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
}
