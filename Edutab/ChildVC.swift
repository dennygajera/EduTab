//
//  ChildVC.swift
//  Edutab
//
//  Created by Chirag Bhojani on 8/28/20.
//  Copyright © 2020 Chirag Bhojani. All rights reserved.
//

import UIKit

class ChildCell: UITableViewCell {
    @IBOutlet weak var lblChild: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblStandard: UILabel!
    @IBOutlet weak var lblSchool: UILabel!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var viewBackground: UIView!
}


class ChildVC: BaseVC {
    
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tblView: UITableView!
    var viewModel: ChildViewModel = ChildViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getChildData()
    }
    
    func getChildData() {
        self.viewModel.apiGetChildData(dicParam: [:]) { (isSuccess, response) in
            if isSuccess! {
                self.viewModel.childData = response
                if self.viewModel.childData.count <= 2{
                    self.btnAdd.isHidden = false
                } else {
                    self.btnAdd.isHidden = true
                }
                self.tblView.delegate = self
                self.tblView.dataSource = self
                self.tblView.reloadData()
            }
        }
    }
    
    @IBAction func btnBackClick(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddClick(_ sender: AnyObject) {
        let add = Storyboard.main.storyboard().instantiateViewController(withIdentifier: Identifier.AddChild.rawValue) as! AddChildVC
        self.navigationController?.pushViewController(add, animated: true)
    }
}

extension ChildVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.childData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.ChildCell.rawValue, for: indexPath) as! ChildCell
        let singleChildData = self.viewModel.childData[indexPath.row]
        cell.lblChild.text = String(singleChildData.name!.prefix(1))
        cell.lblName.text = singleChildData.name
        cell.lblStandard.text = singleChildData.std
        cell.lblSchool.text = singleChildData.school_name
        cell.btnEdit.tag = indexPath.row
        cell.btnRemove.tag = indexPath.row
        cell.btnEdit.addTarget(self, action: #selector(btnEditClick(btn:)), for: .touchUpInside)
        cell.btnRemove.addTarget(self, action: #selector(btnDeleteClick(btn:)), for: .touchUpInside)
        self.setShadow(view: cell.viewBackground)
        return cell
    }
    
    @objc func btnDeleteClick(btn: UIButton) {

        
        let selectedChildData = self.viewModel.childData[btn.tag]
        
        var deleteChildRequest: DeleteChildRequest = DeleteChildRequest()
        deleteChildRequest.id = selectedChildData.id
        self.viewModel.apiDeleteChildData(dicParam: deleteChildRequest.dictionary, id: selectedChildData.id!) { (isSuccess, response) in
            if isSuccess! {
                self.getChildData()
            }
        }
    }
    
    @objc func btnEditClick(btn: UIButton) {
        let singleChild = self.viewModel.childData[btn.tag]
        let add = Storyboard.main.storyboard().instantiateViewController(withIdentifier: Identifier.AddChild.rawValue) as! AddChildVC
        add.selectedChild = singleChild
        self.navigationController?.pushViewController(add, animated: true)
    }
}
