//
//  HomeViewModel.swift
//  Edutab
//
//  Created by Chirag Bhojani on 8/28/20.
//  Copyright © 2020 Chirag Bhojani. All rights reserved.
//

import UIKit
import RxSwift

struct HomeViewModel {
    func apiDashBoard(dicParam: [String: Any], completion :@escaping (_ isSucess : Bool?,_ receivedData: NSDictionary?) -> Void) {
        ServiceManager.sharedInstance.getRequest(parameterDict: dicParam, URL: API.dashboard.URL) { (response, error) in
            do {
                if response != nil {
                    completion(true, response)
                } else {
                    completion(false, nil)
                }
            }
        }
    }
}
