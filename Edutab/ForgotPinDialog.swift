//
//  ForgotPinDialog.swift
//  Edutab
//
//  Created by Chirag Bhojani on 8/28/20.
//  Copyright © 2020 Chirag Bhojani. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

@objc protocol ForgotPinDelegate: class {
    func saveButtonClickHandler(obj: UIButton)
    func cancelButtonClickHandler(obj: UIButton)
    @objc optional func centerButtonClickHandler()
}

class ForgotPinDialog: UIViewController {
    
    @IBOutlet weak var txtOldPin: JVFloatLabeledTextField!
    @IBOutlet weak var txtNewPin: JVFloatLabeledTextField!
    weak var delegate: ForgotPinDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btnSaveClick(_ sender: UIButton) {
        delegate?.saveButtonClickHandler(obj: sender)
    }
    
    @IBAction func btnCancelClick(_ sender: UIButton) {
        delegate?.cancelButtonClickHandler(obj: sender)
    }
}


