//
//  TextFieldStyle.swift
//  ATLibrary

import Foundation

/// Define las posibles modificaciones de estilo para un TextField
public struct TextFieldStyle: Style {
    
    /// Si hay linea bordeando el TextField por la parte inferior, `true` por defecto
    var bottomLine: Bool
    
    /// Color del borde inferior, `blanco` por defecto
    var bottomLineColor: UIColor
    
    /// Altura del borde inferior, `0,75` por defecto
    var bottomLineHeight: CGFloat
    
    /// Color del texto, `blanco` por defecto
    var textColor: UIColor
    
    /// Fuente del texto, `nil` por defecto
    var textFont: UIFont?
    
    /// Color del texto placeholder, `nil` por defecto
    var placeHolderTextColor: UIColor?
    
    public init(
            bottomLine: Bool                = true,
            bottomLineColor: UIColor        = .white,
            bottomLineHeight: CGFloat       = 0.75,
            textColor: UIColor              = .white,
            textFont: UIFont?               = nil,
            placeHolderTextColor: UIColor?  = nil) {
        
        self.bottomLine = bottomLine
        self.bottomLineColor = bottomLineColor
        self.bottomLineHeight = bottomLineHeight
        self.textColor = textColor
        self.textFont = textFont
        self.placeHolderTextColor = placeHolderTextColor
    }
}

public extension TextFieldStyle {
    
    /// Todos los valores por defecto
    static var `default`: TextFieldStyle {
        return TextFieldStyle()
    }
}
