//
//  IDOTPBaseTextField.swift
//  IDOTPTextField
//
//  Created by Kirill Pustovalov on 03.01.2021.
//

import UIKit

@IBDesignable
public class IDOTPInitialTextField: IDOTPTextField<IDOTPInitialTextFieldLabel> {
    @IBInspectable
    public override var numberOfDigits: Int { didSet { redraw() } }

    @IBInspectable
    public override var spacing: Int { didSet { redraw() } }

    @IBInspectable
    public var boxBackgroundColor: UIColor = .white {
        didSet { redraw() }
    }

    @IBInspectable
    public var borderHeight: CGFloat = 2 {
        didSet { redraw() }
    }

    @IBInspectable
    public var borderColor: UIColor = .lightGray {
        didSet { redraw() }
    }

    @IBInspectable
    public var cornerRadius: CGFloat = 0 {
        didSet { redraw() }
    }

    public override func redraw() {
        super.redraw()
        labels.forEach { (label) in
            label.layer.backgroundColor = boxBackgroundColor.cgColor
            label.borderHeight = borderHeight
            label.cornerRadius = cornerRadius
            label.borderColor = borderColor
        }
    }
}
