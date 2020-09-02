//
//  UITextField+.swift
//  FullKit
//
//  Created by Darshan Gajera on 21/06/18.
//  Copyright © 2018 Darshan Gajera. All rights reserved.
//

import Foundation
import UIKit
//swiftlint:disable all
private var __maxLengths = [UITextField: Int]()

extension UITextField {
    
        @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
               return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    
    @objc func fix(textField: UITextField) {
//        let t = textField.text
//        textField.text = t?.prefix(maxLength)
        
        textField.text = String(textField.text!.prefix(maxLength))
    }
    
    func setPadding(left: CGFloat? = nil, right: CGFloat? = nil){
        if let left = left {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.size.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }

        if let right = right {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.size.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    func setRightView(img: UIImage) {
        let imageView = UIImageView(image: img)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        self.rightViewMode = .always
        self.rightView = imageView
    }
    
    func setLeftIcon(_ icon: UIImage) {
        
        let padding = 20
        let size = 20
        
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: size+padding, height: size) )
        let iconView  = UIImageView(frame: CGRect(x: (Int(outerView.bounds.width) - size) / 2, y: 0, width: size, height: size))
        iconView.image = icon
        outerView.addSubview(iconView)
        
        leftView = outerView
        leftViewMode = .always
    }
    
    @IBInspectable
    var setScalable: Bool {
        set{
            var fontValue = self.font?.pointSize
            if Display.typeIsLike == .iphone5 {
                fontValue = fontValue!
            } else if Display.typeIsLike == .iphone6 || Display.typeIsLike == .iphoneX {
                fontValue = fontValue! + 1
            } else if Display.typeIsLike == .iphone6plus {
                fontValue = fontValue! + 2
            }
            self.font =  UIFont(name: (self.font?.fontName)!, size: CGFloat(fontValue!))!
        }
        get{
            return true
        }
    }
}
