//
//  AddChildViewModel.swift
//  Edutab
//
//  Created by Darshan on 02/09/20.
//  Copyright © 2020 Chirag Bhojani. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
struct AddChildRequest: Encodable {
    var id: String?
    var name: String?
    var birth_date: String?
    var std: String?
    var school_name: String?
}

struct AddChildViewModel {
    let firstName = Variable<String>("")
    let lastName = Variable<String>("")
    let childStandard = Variable<String>("")
    let schoolname = Variable<String>("")
}

extension AddChildViewModel {
    
    func fieldValidation() -> Bool {
        if firstName.value.isEmpty {
            SnackBar.show(strMessage: ErrorMesssages.EmptyFirstName, type: .negative)
            return false
        } else if lastName.value.isEmpty {
            SnackBar.show(strMessage: ErrorMesssages.EmptyLastName, type: .negative)
            return false
        } else if childStandard.value.isEmpty {
            SnackBar.show(strMessage: ErrorMesssages.emptyPhone, type: .negative)
            return false
        } else if schoolname.value.isEmpty {
            SnackBar.show(strMessage: ErrorMesssages.EmptyEmail, type: .negative)
            return false
        } else {
            return true
        }
    }
    
    func apiAddChildData(dicParam: [String: Any], completion :@escaping (_ isSucess : Bool?,_ receivedData: [childResponse]?) -> Void) {
        ServiceManager.sharedInstance.postRequest(parameterDict: dicParam, URL: API.addChild.URL) { (response, error) in
            do {
                if response != nil {
                    completion(true,nil)
                    
                } else {
                    completion(false, nil)
                }
            }
        }
    }

    func apiUpdateChildData(dicParam: [String: Any], id: String, completion :@escaping (_ isSucess : Bool?,_ receivedData: [childResponse]?) -> Void) {
        let url = "\(API.editChild.URL)\(id)"
        
        ServiceManager.sharedInstance.postRequest(parameterDict: dicParam, URL: url) { (response, error) in
            do {
                if response != nil {
                    completion(true,nil)
                } else {
                    completion(false, nil)
                }
            }
        }
    }
}
