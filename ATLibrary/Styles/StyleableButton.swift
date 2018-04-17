//
//  StyleableButton.swift
//  ATLibrary

import UIKit

@IBDesignable open class StyleableButton: UIButton, StyleApplicable {
    public typealias style = ButtonStyle
    
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
