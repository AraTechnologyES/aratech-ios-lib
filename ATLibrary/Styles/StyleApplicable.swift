//
//  StyleApplicable.swift
//  ATLibrary

import Foundation
import UIKit

public protocol Style { }

public protocol StyleApplicable {
    associatedtype style: Style
    
    /// Estilo del objeto
    var style: style? { get set }
}

public extension StyleApplicable where Self: UIButton, style == ButtonStyle {
    
    /**
     Aplica al UIButton el estilo proporcionado
     
     - parameter style: Estilo a aplicar al UIButton
     */
    public func apply(style: ButtonStyle) {
        
        // Hay que comprobar que sea distinta a la que ya hay para evitar bucles con layoutSubviews
        if let insets = style.insets, insets != self.contentEdgeInsets {
            self.contentEdgeInsets = insets
        }

        if style.roundedBorder {
            
            self.clipsToBounds = true
            self.imageView?.clipsToBounds = true
            
            if let cornerRadius = style.cornerRadius {
                self.layer.cornerRadius = cornerRadius
            } else {
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
        
        if let images = style.backgroundImages {
            for (image, state) in images {
                self.setBackgroundImage(image, for: state)
            }
        }
        
        self.backgroundColor = style.backgroundColor
        
        // Hay que comprobar que sea distinta a la que ya hay para evitar bucles con layoutSubviews
        if let titleFont = style.titleFont, titleFont != self.titleLabel?.font {
            self.titleLabel?.font = titleFont
        }
        
        for (color,state) in style.titleColors {
            self.setTitleColor(color, for: state)
        }
    }
}


public extension StyleApplicable where Self: UITextField, style == TextFieldStyle {

    fileprivate func addBorder(withHeight height: CGFloat = 1.5, color: UIColor = .lightGray) {
        let bottomBorder = CALayer()
		bottomBorder.accessibilityLabel = "bottomBorder"
        bottomBorder.frame = CGRect(x: 0, y: frame.size.height - 3, width: frame.size.width, height: height)
        bottomBorder.backgroundColor = color.cgColor
        self.layer.addSublayer(bottomBorder)
    }
	
	fileprivate func removeBorder() {
		if let layers = self.layer.sublayers {
			for layer in layers {
				if layer.accessibilityLabel == "bottomBorder" {
					layer.removeFromSuperlayer()
				}
			}
		}
	}
    
    /**
     Aplica al TextField el estilo proporcionado
     
     - parameter style: Estilo a aplicar al TextField
     */
    public func apply(style: TextFieldStyle) {
        
        if style.bottomLine {
			removeBorder()
            addBorder(withHeight: style.bottomLineHeight, color: style.bottomLineColor)
        }
        
        textColor = style.textColor
        
        // Hay que comprobar que sea distinta a la que ya hay para evitar bucles con layoutSubviews
        if let textFont = style.textFont, textFont != self.font {
            self.font = textFont
        }
        
        if  let placeHolderTextColor = style.placeHolderTextColor,
            let placeholderText = placeholder {
            
            let attributedPlaceholder = NSMutableAttributedString.init(string: placeholderText)
            attributedPlaceholder.addAttribute(NSAttributedStringKey.foregroundColor, value: placeHolderTextColor, range: NSMakeRange(0, placeholderText.count))
            
            self.attributedPlaceholder = attributedPlaceholder
        }
    }
}
