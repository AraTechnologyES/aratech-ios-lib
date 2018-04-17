//
//  Color.swift
//  ATLibrary

import Foundation

//MARK:- Color

public struct Color {
    
    public struct Gray {
        /// Hex: #e6e6e6
        public static let background = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        /// Hex: #383431
        public static let dark = UIColor(red: 56.0/255.0, green: 52.0/255.0, blue: 49.0/255.0, alpha: 1.0)
    }
    
    //TODO:- Hacer que el random sea sobre una base de colores definidos
    public static func random() -> UIColor{
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}
