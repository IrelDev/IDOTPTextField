//
//  IDOTPTextFieldWithOverridenDelegate.swift
//  IDOTPTextField
//
//  Created by Kirill Pustovalov on 03.01.2021.
//

import UIKit

class IDOTPTextFieldWithOverridenDelegate: IDOTPInitialTextField {
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        super.textFieldDidBeginEditing(textField)
    }
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.count == 4 {
            textField.resignFirstResponder()
        }
        
        return super.textField(textField, shouldChangeCharactersIn: range, replacementString: string)
    }
    override func textFieldDidEndEditing(_ textField: UITextField) {
        super.textFieldDidEndEditing(textField)
    }
}
