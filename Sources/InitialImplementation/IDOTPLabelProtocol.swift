//
//  IDOTPLabelProtocol.swift
//  IDOTPTextField
//
//  Created by Kirill Pustovalov on 03.01.2021.
//

import UIKit

public protocol IDOTPLabelProtocol: UIView {
    var isActive: Bool { get set }
    var text: String? { get set }
    var textColor: UIColor! { get set }
    var font: UIFont! { get set }
    func updateState()
}
