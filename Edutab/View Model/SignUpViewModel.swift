//
//  LoginViewModel.swift
//  Edutab
//
//  Created by Chirag Bhojani on 8/27/20.
//  Copyright © 2020 Chirag Bhojani. All rights reserved.
//

import UIKit
import RxSwift

struct SignUpViewModel {
    let firstName = Variable<String>("")
    let lastName = Variable<String>("")
    let mobileNumber = Variable<String>("")
    let email = Variable<String>("")
    let password = Variable<String>("")
    let confirmPassword = Variable<String>("")
    let address = Variable<String>("")
    let city = Variable<String>("")
    let state = Variable<String>("")
    let pincode = Variable<String>("")
}

struct SignUpRequest: Encodable {
    var mobile: String?
    var name: String?
    var email: String?
    var address: String?
    var city: String?
    var state: String?
    var pincode: String?
    var device_token: String?
    var password: String?
}

extension SignUpViewModel {
    func fieldValidation() -> Bool {
        if firstName.value.isEmpty {
            SnackBar.show(strMessage: ErrorMesssages.EmptyFirstName, type: .negative)
            return false
        } else {
            if lastName.value.isEmpty {
                SnackBar.show(strMessage: ErrorMesssages.EmptyLastName, type: .negative)
                return false
            } else {
                if mobileNumber.value.isEmpty {
                    SnackBar.show(strMessage: ErrorMesssages.emptyPhone, type: .negative)
                    return false
                } else {
                    if email.value.isEmpty {
                        SnackBar.show(strMessage: ErrorMesssages.EmptyEmail, type: .negative)
                        return false
                    } else {
                        if password.value.isEmpty {
                            SnackBar.show(strMessage: ErrorMesssages.EmptyPassword, type: .negative)
                            return false
                        } else {
                            if confirmPassword.value.isEmpty {
                                SnackBar.show(strMessage: ErrorMesssages.emptyPassword, type: .negative)
                                return false
                            } else {
                                if password.value != confirmPassword.value {
                                    SnackBar.show(strMessage: ErrorMesssages.ValidPassword, type: .negative)
                                    return false
                                } else {
                                    if address.value.isEmpty {
                                        SnackBar.show(strMessage: ErrorMesssages.EmptyAddress, type: .negative)
                                        return false
                                    } else {
                                        if state.value.isEmpty {
                                            SnackBar.show(strMessage: ErrorMesssages.EmptyState, type: .negative)
                                            return false
                                        } else {
                                            if city.value.isEmpty {
                                                SnackBar.show(strMessage: ErrorMesssages.EmptyCity, type: .negative)
                                                return false
                                            } else {
                                                if pincode.value.isEmpty {
                                                    SnackBar.show(strMessage: ErrorMesssages.EmptyPincode, type: .negative)
                                                    return false
                                                } else {
                                                    return true
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func apiRegistration(dicParam: [String: Any], completion :@escaping (_ isSucess : Bool?,_ receivedData: LoginUserData?) -> Void) {
        ServiceManager.sharedInstance.postRequest(parameterDict: dicParam, URL: API.register.URL) { (dicResponse, error) in
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
    
    func apiTermsAndCondiction(dicParam: [String: Any], completion :@escaping (_ isSucess : Bool?,_ receivedData: NSDictionary?) -> Void) {
        ServiceManager.sharedInstance.getRequest(parameterDict: [:], URL: API.TermsAndConditions.URL) { (dicResponse, error) in
            do {
                if dicResponse != nil {
                    completion(false, dicResponse)
                } else {
                    completion(false, nil)
                }
            }
        }
    }
}
