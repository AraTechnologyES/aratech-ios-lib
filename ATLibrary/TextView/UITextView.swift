//
//  UITextView.swift
//  ATLibrary

import Foundation

extension UITextView {
    
    
    /// Establece el texto en el textView
    ///
    /// - Parameters:
    ///   - text: Texto para el textView
    ///   - fullHeight: Si se desea que el textView tenga la altura necesaria para mostrar todo el texto, `true` por defecto
    ///   - heightConstraint: Restricción de la altura del textView
    open func setTextView(text: String, fullHeight: Bool = true, heightConstraint: NSLayoutConstraint) {
        if fullHeight {
            heightConstraint.isActive = false
            self.isScrollEnabled = true
            self.text = text
            self.sizeToFit()
        } else {
            heightConstraint.isActive = true
            self.text = text
        }
        self.isScrollEnabled = false
    }
}
