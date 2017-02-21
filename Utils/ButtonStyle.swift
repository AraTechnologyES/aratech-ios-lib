//
//  ButtonStyle.swift
//  Utils

import Foundation

/// Define las posibles modificaciones de estilo para un UIButton
public struct ButtonStyle: Style {
    
    /// Indica si se desea el borde redondeado
    public var roundedBorder:      Bool
    
    /// Si roundedBorder, se aplica height/2 al borde si nil, el valor dado en otro caso
    public var cornerRadius:       CGFloat?
    
    /// Color de fondo
    public var backgroundColor:    UIColor
    
    /// Color del titulo
    public var titleColor:         UIColor
    
    /// Fuente del titulo
    public var titleFont:          UIFont?
    
    /// Insets: Distancia entre los extremos del boton y el titulo
    public var insets:             UIEdgeInsets?
    
    public init(
            roundedBorder:   Bool           = true,
            cornerRadius:    CGFloat?       = nil,
            backgroundColor: UIColor        = .clear,
            titleColor:      UIColor        = UIColor.white,
            titleFont:       UIFont?        = UIFont.systemFont(ofSize: 15.0),
            insets:          UIEdgeInsets   = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)) {
        
        self.roundedBorder      = roundedBorder
        self.cornerRadius       = cornerRadius
        self.backgroundColor    = backgroundColor
        self.titleColor         = titleColor
        self.titleFont          = titleFont
        self.insets             = insets
    }
}

public extension ButtonStyle {
    
    /// Estilo para el boton de login
    public static var login: ButtonStyle {
        return ButtonStyle(roundedBorder: true, insets: UIEdgeInsets(top: 5.0, left: 20.0, bottom: 5.0, right: 20.0))
    }
}
