//
//  IDOTPTextField.swift
//  IDOTPTextField
//
//  Created by Kirill Pustovalov on 03.01.2021.
//

import UIKit

@IBDesignable
open class IDOTPTextField<Label: IDOTPLabelProtocol>: UITextField, UITextFieldDelegate {
    @IBInspectable
    public var numberOfDigits: Int = 4 {
        didSet { redraw() }
    }
    @IBInspectable
    public var spacing: Int = 8 {
        didSet { redraw() }
    }
    public var labels: [Label] {
        return stackView.arrangedSubviews.compactMap({ $0 as? Label })
    }
    open override var text: String? {
        didSet {
            self.changeText(oldValue: oldValue, newValue: text)
        }
    }
    open override var font: UIFont? {
        didSet {
            redraw()
        }
    }
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: self.bounds)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.isUserInteractionEnabled = false
        stackView.spacing = CGFloat(spacing)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private var _textColor: UIColor?
    open override var textColor: UIColor? {
        didSet {
            if textColor == .clear { return }
            _textColor = textColor
            redraw()
            
            textColor = .clear
        }
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    private func setup() {
        textColor = .clear
        keyboardType = .numberPad
        borderStyle = .none
        
        textContentType = .oneTimeCode
        addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        delegate = self
        addSubview(stackView)
        setupConstraints()
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    open override func setNeedsLayout() {
        super.setNeedsLayout()
        stackView.frame = bounds
    }
    open func redraw() {
        stackView.spacing = CGFloat(spacing)
        
        stackView.arrangedSubviews.forEach { (v) in
            stackView.removeArrangedSubview(v)
            v.removeFromSuperview()
        }
        for _ in 0 ..< self.numberOfDigits {
            let label = Label(frame: .zero)
            label.textColor = _textColor
            label.font = font
            label.isUserInteractionEnabled = false
            self.stackView.addArrangedSubview(label)
        }
    }
    private func updateFocus() {
        let focusIndex = text?.count ?? 0
        labels.enumerated().forEach { (i, label) in
            label.isActive = i == focusIndex
        }
    }
    private func removeFocus() {
        let focusIndex = text?.count ?? 0
        guard focusIndex < numberOfDigits else {
            return
        }
        labels[focusIndex].isActive = false
    }
    @objc public func textFieldDidChange(textField: UITextField) {
        guard let text = text, text.count <= numberOfDigits else { return }
        
        labels.enumerated().forEach({ (i, label) in
            
            if i < text.count {
                let index = text.index(text.startIndex, offsetBy: i)
                let char = isSecureTextEntry ? "●" : String(text[index])
                label.text = char
            }
        })
        updateFocus()
    }
    private func changeText(oldValue: String?, newValue: String?) {
        guard let text = text, text.count <= numberOfDigits else { return }
        
        labels.enumerated().forEach({ (i, label) in
            
            if i < text.count {
                let index = text.index(text.startIndex, offsetBy: i)
                let char = isSecureTextEntry ? "●" : String(text[index])
                label.text = char
                label.updateState()
            }
        })
        if self.isFirstResponder {
            updateFocus()
        }
    }
    open override func caretRect(for position: UITextPosition) -> CGRect {
        let index = self.text?.count ?? 0
        guard index < stackView.arrangedSubviews.count else {
            return .zero
        }
        
        let viewFrame = self.stackView.arrangedSubviews[index].frame
        let caretHeight = self.font?.pointSize ?? ceil(self.frame.height * 0.6)
        return CGRect(x: viewFrame.midX - 1, y: ceil((self.frame.height - caretHeight) / 2), width: 2, height: caretHeight)
    }
    
    // MARK: - UITextFieldDelegate
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard var text = self.text else {
            return false
        }
        
        if string.isEmpty, text.isEmpty == false {
            labels[text.count - 1].text = nil
            text.removeLast()
            self.text = text
            updateFocus()
            return false
        }
        
        return text.count < numberOfDigits
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        updateFocus()
    }
    public func textFieldDidEndEditing(_ textField: UITextField) {
        removeFocus()
    }
}
