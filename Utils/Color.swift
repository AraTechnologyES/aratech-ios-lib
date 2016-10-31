//
//  Color.swift
//  Utils

import Foundation

//MARK:- Color

struct Color {
    
    /// Hex: #e41741
    static let red = UIColor(colorLiteralRed: 228.0/255.0, green: 23.0/255.0, blue: 65.0/255.0, alpha: 1.0)
    
    struct Gray {
        /// Hex: #949599
//        static let light = UIColor(hex: "#949599") //UIColor(red: 148.0, green: 149.0, blue: 153.0, alpha: 1.0)
        /// Hex: #e6e6e6
        static let background = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        /// Hex: #383431
        static let dark = UIColor(red: 56.0/255.0, green: 52.0/255.0, blue: 49.0/255.0, alpha: 1.0)
    }
    
    //TODO:- Hacer que el random sea sobre una base de colores definidos
    static func random() -> UIColor{
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}
