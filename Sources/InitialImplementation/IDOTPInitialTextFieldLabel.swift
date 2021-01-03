//
//  IDOTPBaseTextFieldLabel.swift
//  IDOTPTextField
//
//  Created by Kirill Pustovalov on 03.01.2021.
//

import UIKit

final public class IDOTPInitialTextFieldLabel: UIView, IDOTPLabelProtocol {
    public var text: String? {
        didSet { label.text = text }
    }

    public var font: UIFont! {
        didSet { label.font = font }
    }

    public var isActive = false {
        didSet {
            updateActive(oldValue: oldValue, newValue: isActive)
        }
    }

    var borderColor: UIColor? {
        didSet { redraw() }
    }

    var borderHeight: CGFloat = 2 {
        didSet { redraw() }
    }

    var cornerRadius: CGFloat = 0 {
        didSet { redraw() }
    }

    public var textColor: UIColor! {
        didSet {
            self.label.textColor = textColor
        }
    }

    private var animator = UIViewPropertyAnimator()
    private let label: UILabel
    private let bottomBorder = UIView()

    private var hasText: Bool {
        return self.text?.isEmpty == false
    }

    override init(frame: CGRect) {
        self.label = UILabel(frame: frame)
        super.init(frame: frame)
        self.addSubview(label)
        self.addSubview(bottomBorder)
        label.alpha = 0
        self.label.textAlignment = .center
        self.layer.masksToBounds = true
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.label.frame = self.bounds.offsetBy(dx: 0, dy: -borderHeight / 2)
        self.bottomBorder.frame = CGRect(x: 0, y: self.frame.height - borderHeight, width: self.frame.width, height: borderHeight)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func updateState() {
        self.stopAnimation()
    }

    private func updateActive(oldValue: Bool, newValue: Bool) {
        guard oldValue != newValue else { return }

        if newValue == true {
            self.startAnimation()
        } else {
            self.stopAnimation()
        }
    }

    private func redraw() {
        self.layer.cornerRadius = self.cornerRadius
        self.bottomBorder.backgroundColor = self.borderColor
    }

    private func startAnimation() {
        animator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.9, animations: {
            self.label.alpha = 0
        })
        animator.startAnimation()
    }

    private func stopAnimation() {
        animator.addAnimations {
            self.label.alpha = 1
        }
        animator.startAnimation()
    }
}
