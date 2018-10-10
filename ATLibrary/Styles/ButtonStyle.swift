//
//  ButtonStyle.swift
//  ATLibrary

import Foundation

/// Define las posibles modificaciones de estilo para un UIButton
public struct ButtonStyle: Style {
    
    /// Indica si se desea el borde redondeado, `true` por defecto
    public var roundedBorder:      Bool
    
    /// Si roundedBorder, se aplica height/2 al borde si nil, el valor dado en otro caso. `nil` por defecto
    public var cornerRadius:       CGFloat?
    
    /// Imagenes de fondo
	public var backgroundImages:          [(UIImage, UIControl.State)]?
    
    /// Color de fondo, `clear` por defecto
    public var backgroundColor:    UIColor
    
    /// Color del titulo, `white` por defecto
	public var titleColors:               [(UIColor,UIControl.State)]
    
    /// Fuente del titulo, `nil` por defecto
    public var titleFont:          UIFont?
	
	/// Configuración para la sombra
	public var shadowConfiguration: CALayer.ShadowConfiguration?
    
    /// Insets: Distancia entre los extremos del boton y el titulo, `(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)` por defecto
    public var insets:             UIEdgeInsets?
    
    public init(
            roundedBorder:      	Bool                            	= true,
            cornerRadius:       	CGFloat?                        	= nil,
			backgroundImages:   	[(UIImage,UIControl.State)]?     	= nil,
            backgroundColor:    	UIColor                         	= .clear,
			titleColors:        	[(UIColor,UIControl.State)]      = [(UIColor.black, .normal),(UIColor.white, .selected)],
            titleFont:          	UIFont?                        	= nil,
            insets:             	UIEdgeInsets                    	= UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0),
			shadowConfiguration: 	CALayer.ShadowConfiguration? 	= nil) {
        
        self.roundedBorder = roundedBorder
        self.cornerRadius = cornerRadius
        self.backgroundImages = backgroundImages
        self.backgroundColor = backgroundColor
        self.titleColors = titleColors
        self.titleFont = titleFont
        self.insets = insets
		self.shadowConfiguration = shadowConfiguration
    }
}

public extension ButtonStyle {
    
    /// Todos los valores por defecto
    public static var `default`: ButtonStyle {
        return ButtonStyle()
    }
}
