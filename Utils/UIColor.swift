//
//  UIColor.swift
//  Utils
//
//  Created by Aratech iOS on 24/1/17.
//  Copyright © 2017 AraTech. All rights reserved.
//

import Foundation

extension UIColor {
    
    /// Calcula el color correspondiente al código hexadecimal.
    ///
    /// - Parameter hex: Código hexadecimal del color. El código puede tener el formato #RRGGBB ó #AARRGGBB, siendo A el alfa, r rojo, g verde y b azul. Cada cifra está en formato hexadecimal: 0...F
    convenience init?(hex: String) {
        var hex = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hex.hasPrefix("#") {
            // El código contiene el caracter '#', eliminar
            hex.remove(at: hex.startIndex)
        }
        
        // Se escanea el string para convertirlo en Int
        var rgbValue:UInt32 = 0
        if !Scanner(string: hex).scanHexInt32(&rgbValue) {
            return nil
        }
        
        self.init(hexCode: rgbValue)
    }
    
    /// Calcula el color correspondiente al código hexadecimal.
    ///
    /// - Parameter hex: Código hexadecimal del color. El código puede tener el formato 0xRRGGBB ó 0xAARRGGBB, siendo A el alfa, r rojo, g verde y b azul. Cada cifra está en formato hexadecimal: 0...F
    convenience init(hexCode: UInt32) {
        var components: (A:CGFloat,R:CGFloat,G:CGFloat,B:CGFloat)
        
        if hexCode & 0xFF000000 > 0 {
            // El código contiene componente alfa
            components.A = CGFloat((hexCode & 0xFF000000) >> 24) / 255.0
        } else {
            // El código no contiene componente alfa
            components.A = CGFloat(1.0)
        }
        
        components.R = CGFloat((hexCode & 0xFF0000) >> 16) / 255.0
        components.G = CGFloat((hexCode & 0x00FF00) >> 08) / 255.0
        components.B = CGFloat((hexCode & 0x0000FF) >> 00) / 255.0
        
        self.init(red: components.R, green: components.G, blue: components.B, alpha: components.A)
    }
}
