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
    public var boxBackgroundColor: UIColor = .clear {
        didSet { redraw() }
    }
    
    @IBInspectable
    public var borderHeight: CGFloat = 2 {
        didSet { redraw() }
    }
    
    @IBInspectable
    public var borderColor: UIColor = .clear {
        didSet { redraw() }
    }
    
    @IBInspectable
    public var cornerRadius: CGFloat = 0 {
        didSet { redraw() }
    }
    //background color of the box in active state
    @IBInspectable
    public var activeBoxBackgroundColor: UIColor = .clear {
        didSet { redraw() }
    }
    
    //background color of the box if a text is entered
    @IBInspectable
    public var filledBoxBackgroundColor: UIColor = .clear {
        didSet { redraw() }
    }
    
    //border color of the box in normal state
    
    //border color of the box in active
    @IBInspectable
    public var activeBorderColor: UIColor? {
        didSet { redraw() }
    }
    
    //border color of the box if a text is entered
    @IBInspectable
    public var filledBorderColor: UIColor? {
        didSet { redraw() }
    }
    
    
    //placeholder text
    @IBInspectable
    public var boxPlaceholder: String? {
        didSet { redraw() }
    }
    
    //placeholder text color
    @IBInspectable
    public var boxPlaceholderColor: UIColor? = .gray {
        didSet { redraw() }
    }
    
    public override func redraw() {
        super.redraw()
        labels.forEach { (label) in
            label.layer.backgroundColor = boxBackgroundColor.cgColor
            label.borderHeight = borderHeight
            label.cornerRadius = cornerRadius
            label.borderColor = borderColor
            label.backgroundColor = boxBackgroundColor
            label.activeBackgroundColor = activeBoxBackgroundColor
            label.filledBackgroundColor = filledBoxBackgroundColor
            label.activeBorderColor = activeBorderColor
            label.borderColor = borderColor
            label.cornerRadius = cornerRadius
            label.filledBorderColor = filledBorderColor
            label.placeholder = boxPlaceholder
            label.placeholderColor = boxPlaceholderColor
        }
    }
}
