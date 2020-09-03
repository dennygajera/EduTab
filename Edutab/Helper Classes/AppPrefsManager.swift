//
//  AppPrefsManager.swift
//  PastZero
//
//  Created by Sunil Zalavadiya on 7/28/16.
//  Copyright © 2016 Sunil Zalavadiya. All rights reserved.
//

import UIKit
import CoreLocation
// swiftlint:disable all
class AppPrefsManager: NSObject {
    
    static let sharedInstance = AppPrefsManager()
    let TOKEN = "token"
    let APNSTOKEN = "APNSToken"
    let JWTTOKEN = "jwttoken"
    let CURRENTLAT = "CURRENTLAT"
    let CURRENTLONG = "CURRENTLONG"
    let USER = "USER"
    let DEVICEID = "DEVICEID"
    let ISINTROFINISH = "ISINTROFINISH"
    let PRODUCTYOUTUBELINK = "PRODUCTYOUTUBELINK"
    let HOWTOGETVIDEOURL = "HOWTOGETVIDEOURL"
    
    
    func setDataToPreference(data: AnyObject, forKey key: String) {
        do {
            var archivedData = Data()
            if #available(iOS 11.0, *) {
                archivedData = try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: true)
            } else {
                archivedData = NSKeyedArchiver.archivedData(withRootObject: data)
            }
            UserDefaults.standard.set(archivedData, forKey: key)
            UserDefaults.standard.synchronize()
        }
        catch {
            print("Unexpected error: \(error).")
        }
    }
    
    func getDataFromPreference(key: String) -> AnyObject? {
        let archivedData = UserDefaults.standard.object(forKey: key)
        if(archivedData != nil) {
            do {
                var unArchivedData: Any?
                if #available(iOS 11.0, *) {
                    unArchivedData =  try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(archivedData as! Data) as AnyObject
                } else {
                    unArchivedData = NSKeyedUnarchiver.unarchiveObject(with: archivedData as! Data) as AnyObject
                }
                return unArchivedData as AnyObject
            } catch {
                print("Unexpected error: \(error).")
            }
        }
        return nil
    }
    
    func removeDataFromPreference(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func isKeyExistInPreference(key: String) -> Bool {
        if(UserDefaults.standard.object(forKey: key) == nil) {
            return false
        }
        return true
    }
    
    func setIsIntroFinish(obj: Bool) {
        setDataToPreference(data: obj as AnyObject, forKey: ISINTROFINISH)
    }
    
    func setAPNsToken(obj: AnyObject) {
        setDataToPreference(data: obj as AnyObject, forKey: APNSTOKEN)
    }
    
    func getAPNsToken() -> String? {
        let strToken = getDataFromPreference(key: APNSTOKEN)
        return strToken as? String
    }
    
    func setDeviceId(obj: AnyObject) {
        setDataToPreference(data: obj as AnyObject, forKey: DEVICEID)
    }
    
    func getDeviceId() -> String? {
        let strToken = getDataFromPreference(key: DEVICEID)
        return strToken as? String
    }
    
    func setToken(obj: AnyObject) {
        setDataToPreference(data: obj as AnyObject, forKey: TOKEN)
    }
    
    func getToken() -> String? {
        let strToken = getDataFromPreference(key: TOKEN)
        return strToken as? String
    }
    
    func setCurrentLat(obj: String) {
        setDataToPreference(data: obj as AnyObject, forKey: CURRENTLAT)
    }
    
    func getCurrentLat() -> String? {
        let strToken = getDataFromPreference(key: CURRENTLAT)
        return strToken as? String
    }
    
    func setCurrentLong(obj: String) {
        setDataToPreference(data: obj as AnyObject, forKey: CURRENTLONG)
    }
    
    func getCurrentLong() -> String? {
        let strToken = getDataFromPreference(key: CURRENTLONG)
        return strToken as? String
    }
    
    // JWT Token
    func setJWTToken(obj: AnyObject) {
        setDataToPreference(data: obj as AnyObject, forKey: JWTTOKEN)
    }
    
    func getJWTToken() -> String? {
        let strToken = getDataFromPreference(key: JWTTOKEN)
        return strToken as? String
    }

    
    
    func setUserObj(obj: Any) {
        setDataToPreference(data: obj as AnyObject, forKey: USER)
       }
    
    func getUserObj() -> LoginUserData? {
        if self.isKeyExistInPreference(key: USER) {
            let user = getDataFromPreference(key: USER) as! NSDictionary
            do {
                let objUser = try JSONDecoder().decode(LoginUserData.self, from: (user.dataReturn(isParseDirect: true))!)
                return objUser
            } catch _ {
                
            }
            return nil
        } else {
            return nil
        }
    }
    
    
       func getProductURL() -> String? {
           let url = getDataFromPreference(key: PRODUCTYOUTUBELINK)
           return url as? String
       }
       
       func setProductURL(obj: AnyObject) {
           setDataToPreference(data: obj as AnyObject, forKey: PRODUCTYOUTUBELINK)
       }
    
    func getHowToURL() -> String? {
              let url = getDataFromPreference(key: HOWTOGETVIDEOURL)
              return url as? String
          }
          
          func setHowToURL(obj: AnyObject) {
              setDataToPreference(data: obj as AnyObject, forKey: HOWTOGETVIDEOURL)
          }
}

