//
//  Constant.swift
//  Whislte
//
//  Created by Darshan Gajera on 5/14/18.
//  Copyright © 2020. All rights reserved.
//
import UIKit
struct GlobalConstants {
    static let APPNAME = "Golf"
    static let spreadSheetID = "15tuICf8aQrDcTJIi_7clfvNaVY00A-QdNQeL53Hf4Kg"
    static let apiKey = "AIzaSyC_AC3OMZwoYigZdvkbjMd55XmRpelLv4c"
    static let clientId = "787090180691-f0qc3v72uf2frqul8mr6o7s6nlsnvju0.apps.googleusercontent.com"
}

enum Storyboard: String {
    case main    = "Main"
    case Introduction = "Introduction"
    case Calendar    = "WWCalendarTimeSelector"
    func storyboard() -> UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}

enum Color: String {
    case SliderSelction  = "0080ff"
    case SliderDefault  = "0048b1"
    
    case SliderTextSelection  = "ffffff"
    case SliderTextDefault  = "7887b5"
    
    case AppColorCode  = "2c378f"
    case GreenColorCode  = "009345"
    case RedColorCode  = "f44336"
    
    
    case SupporterColorCode  = "e9dae7"
    
    case errorRed  = "EA2E31"
    case errorGreen  = "5DC15D"
    
    case TransactionFailed  = "ff4e4e"
    case TransactionSuccess  = "00a71c"
    case TransactionPending  = "ffbf00"
    case WalletFailed  = "ff3b3b"
    
    case WhiteDarkMode  = "feffff"
    func color() -> UIColor {
        return UIColor.hexStringToUIColor(hex: self.rawValue)
    }
}

struct UserType {
    static let Host  = "host"
    static let Player  = "player"
}

enum Identifier: String {
    // Main Storyboard
    case ViewController = "ViewController"
    case register = "SignupVC"
    case mobileVerification = "MobileVerificationVC"
    case InstructionView = "InstructionView"
    case introduction = "IntroductionVC"
    case home = "HomeVC"
    case ForgotPinDialog = "ForgotPinDialog"
    case forgotPin = "ForgotPinVC"
    case child = "ChildVC"
    
    
    //Tableview cell
    case walletCell = "cellWallet"
    case settingCell = "cellSetting"
    case myTeamCell = "cellMyTeam"
    case ChildCell = "ChildCell"
}

struct FirebaseCollection {
    // Main Storyboard
    static let User  = "Users"
    static let Feedback  = "Feedback"
    static let Food  = "Food Vendors"
    static let Floor  = "Floor Plan"
    static let Exhibitor  = "Exhibit Vendors"
    static let Sponsors  = "Sponsors"
    static let Schedule  = "Schedule"
}

struct FirebaseLogEvent {
    static let Login  = "iOS_Login"
    static let ProfileAccept  = "iOS_ProfileAccept"
    static let BuyAddOn  = "iOS_BuyAddOn"
    static let UseSpeakOn  = "iOS_UseSpeakOn"
    static let UseReverse  = "iOS_UseReverse"
}

struct FirebaseLogParameter {
    static let loginUsername  = "loginUsername"
    static let loginUserFbID  = "loginUserFbID"
    static let acceptUsername  = "acceptUsername"
    static let acceptUserFbID  = "acceptUserFbID"
    static let addOnType  = "addOnType"
}

struct ErrorMesssages {
    static let emptyGameId = "Please enter Game ID!"
    static let emptyTicketId = "Please enter Ticket ID!"
    
    static let emptyPhone = "Please enter mobile number"
    static let emptyPassword = "Please enter password"
    static let validPhone = "Please enter valid phone number"
    
    static let validOtp = "Please enter valid OTP"
    static let wrongOTP = "Please enter valid OTP"
    static let wrong = "Something Went Wrong!"
    
    
    static let EmptyEmail = "Email must not be empty"
    static let ValidEmail = "Please enter valid email."
    
    static let EmptyFirstName = "Please enter Firstname."
    static let EmptyLastName = "Please enter Lastname."
    
    static let EmptyPassword = "Please enter Password."
    static let EmptyConfirmPassword = "Please enter Confirm password."
    static let ValidPassword = "Password did not matched."
    
    static let EmptyAddress = "Please enter Address."
    static let EmptyState = "Please enter State."
    static let EmptyCity = "Please enter City."
    static let EmptyPincode = "Please enter Pincode."
    
    static let PrivacyPolicy = "Please accept privacy policy."
    
    
    
}

struct SuccessMessages {
    static let TicketBogusSuccessfully = "Ticket declared bogus."
    static let TicketNumberCopied = "Ticket number copied."
    static let ForcefullyUpdate = "New version is available in app store, Please update app for better experiece"
}
