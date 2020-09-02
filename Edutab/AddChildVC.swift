//
//  AddChildVC.swift
//  Edutab
//
//  Created by Darshan on 02/09/20.
//  Copyright © 2020 Chirag Bhojani. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class AddChildVC: UIViewController {
    
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtFname: UITextField!
    @IBOutlet weak var txtLName: UITextField!
    @IBOutlet weak var txtStandard: UITextField!
    @IBOutlet weak var txtSchoolName: UITextField!
    var selectedChild: childResponse?
    let disposeBag = DisposeBag()
    var viewModel = AddChildViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedChild != nil {
            let arrSub = selectedChild?.name?.split(separator: " ")
            self.txtFname.text = "\(arrSub?.first ?? "")"
            self.txtLName.text = "\(arrSub?.last ?? "")"
            self.txtSchoolName.text = selectedChild?.school_name
            self.txtStandard.text = selectedChild?.std
            btnSubmit.setTitle("Update", for: .normal)
        } else {
            btnSubmit.setTitle("Submit", for: .normal)
        }
        
        self.txtFname.rx.text
            .orEmpty
            .bind(to: viewModel.firstName)
            .disposed(by: disposeBag)
        
        self.txtLName.rx.text
            .orEmpty
            .bind(to: viewModel.lastName)
            .disposed(by: disposeBag)
        
        self.txtStandard.rx.text
            .orEmpty
            .bind(to: viewModel.childStandard)
            .disposed(by: disposeBag)
        
        self.txtSchoolName.rx.text
            .orEmpty
            .bind(to: viewModel.schoolname)
            .disposed(by: disposeBag)
        
        
        
    }
    
    @IBAction func btnSubmitClick(_ sender: AnyObject) {
        if self.viewModel.fieldValidation() {
            var objAddChildRequest = AddChildRequest()
            if selectedChild != nil {
                objAddChildRequest.id = "" //denny
            }
            objAddChildRequest.name = "\(txtFname.text ?? "") \(txtLName.text ?? "")"
            objAddChildRequest.std = txtStandard.text
            objAddChildRequest.school_name = txtSchoolName.text
            
            if selectedChild != nil { // Update
                self.viewModel.apiUpdateChildData(dicParam: objAddChildRequest.dictionary) { (isSuccess, response) in
                    if isSuccess! {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            } else { // Add
                self.viewModel.apiAddChildData(dicParam: objAddChildRequest.dictionary) { (isSuccess, response) in
                    if isSuccess! {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
         }
    }
    
    @IBAction func btnBackClick(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
}
