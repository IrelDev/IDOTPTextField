//
//  IDOTPTextFieldWithOverridenDelegate.swift
//  IDOTPTextField
//
//  Created by Kirill Pustovalov on 03.01.2021.
//

import UIKit

public class IDOTPTextFieldWithOverridenDelegate: IDOTPInitialTextField {
    public override func textFieldDidBeginEditing(_ textField: UITextField) {
        super.textFieldDidBeginEditing(textField)
    }
    public override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return super.textField(textField, shouldChangeCharactersIn: range, replacementString: string)
    }
    public override func textFieldDidEndEditing(_ textField: UITextField) {
        super.textFieldDidEndEditing(textField)
    }
    public override func textFieldDidChange(textField: UITextField) {
        super.textFieldDidChange(textField: textField)
        
        //API CALL
    }
}
