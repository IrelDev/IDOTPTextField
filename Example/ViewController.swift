//
//  ViewController.swift
//  Example
//
//  Created by Kirill Pustovalov on 03.01.2021.
//

import UIKit
import IDOTPTextField

class ViewController: UIViewController {
    let textField: IDOTPTextFieldWithOverridenDelegate = {
        let textField = IDOTPTextFieldWithOverridenDelegate()
        textField.numberOfDigits = 4
        textField.spacing = 10
        textField.boxBackgroundColor = .clear
        textField.borderHeight = 1
        textField.borderColor = .gray
        textField.textColor = .red
        textField.font = UIFont.systemFont(ofSize: 30)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
    }


}

