//
//  ChildViewModel.swift
//  Edutab
//
//  Created by Chirag Bhojani on 8/28/20.
//  Copyright © 2020 Chirag Bhojani. All rights reserved.
//

import UIKit

struct childResponse: Codable {
    var birth_date: String?
    var customer_id: String?
    var id: String?
    var name: String?
    var school_name: String?
    var std: String?
}

struct ChildViewModel {
    
    var childData: [childResponse]!
    
    func apiGetChildData(dicParam: [String: Any], completion :@escaping (_ isSucess : Bool?,_ receivedData: [childResponse]?) -> Void) {
        ServiceManager.sharedInstance.getRequest(parameterDict: dicParam, URL: API.child.URL) { (response, error) in
            do {
                if response != nil {
                    completion(true,try JSONDecoder().decode([childResponse].self, from: (response!.dataReturn(isParseDirect: false))!))
                    
                } else {
                    completion(false, nil)
                }
            } catch let err {
                print(err)
                completion(false, nil)
            }
        }
    }
    
    func apiAddChildData(dicParam: [String: Any], completion :@escaping (_ isSucess : Bool?,_ receivedData: [childResponse]?) -> Void) {
        ServiceManager.sharedInstance.getRequest(parameterDict: dicParam, URL: API.child.URL) { (response, error) in
            do {
                if response != nil {
                    completion(true,try JSONDecoder().decode([childResponse].self, from: (response!.dataReturn(isParseDirect: false))!))
                    
                } else {
                    completion(false, nil)
                }
            } catch let err {
                print(err)
                completion(false, nil)
            }
        }
    }
}
