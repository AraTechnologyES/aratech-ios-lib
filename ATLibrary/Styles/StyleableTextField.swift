//
//  StyleableTextField.swift
//  Utils

import UIKit

@IBDesignable open class StyleableTextField: UITextField, StyleApplicable {
    public typealias style = TextFieldStyle
    
    public var style: style? {
        didSet {
            if let style = self.style {
                self.apply(style: style)
            }
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if let style = self.style {
            self.apply(style: style)
        }
    }
}
