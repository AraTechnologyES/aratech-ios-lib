//
//  StyleApplicable.swift
//  Utils

import Foundation
import UIKit

public protocol Style { }

public protocol StyleApplicable {
    associatedtype style: Style
}

public extension StyleApplicable where Self: UIButton, style == ButtonStyle {
    
    /**
     Aplica al UIButton el estilo proporcionado
     
     - parameter style: Estilo a aplicar al UIButton
     */
    public func apply(style: ButtonStyle) {
        
        if let insets = style.insets {
            self.contentEdgeInsets = insets
        }
        
        if style.roundedBorder {
            if let cornerRadius = style.cornerRadius {
                self.layer.cornerRadius = cornerRadius
            } else {
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
        
        self.backgroundColor = style.backgroundColor
        
        self.titleLabel?.font = style.titleFont
        self.titleLabel?.textColor = style.titleColor
    }
}


public extension StyleApplicable where Self: UITextField, style == TextFieldStyle {

    fileprivate func addBorder(withHeight height: CGFloat = 1.5, color: UIColor = .lightGray) {
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: frame.size.height - 3, width: frame.size.width, height: height)
        bottomBorder.backgroundColor = color.cgColor
        self.layer.addSublayer(bottomBorder)
    }
    
    /**
     Aplica al TextField el estilo proporcionado
     
     - parameter style: Estilo a aplicar al TextField
     */
    public func apply(style: TextFieldStyle) {
        
        if style.bottomLine {
            addBorder(withHeight: style.bottomLineHeight, color: style.bottomLineColor)
        }
        
        textColor = style.textColor
        font = style.textFont
        
        if  let placeHolderTextColor = style.placeHolderTextColor,
            let placeholderText = placeholder {
            
            let attributedPlaceholder = NSMutableAttributedString.init(string: placeholderText)
            attributedPlaceholder.addAttribute(NSForegroundColorAttributeName, value: placeHolderTextColor, range: NSMakeRange(0, placeholderText.characters.count))
            
            self.attributedPlaceholder = attributedPlaceholder
        }
        
        self.setNeedsLayout()
    }
}
