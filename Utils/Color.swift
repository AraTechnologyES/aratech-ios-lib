//
//  Color.swift
//  Utils

import Foundation

//MARK:- Color

public struct Color {
    
    public struct Red {
        /// #FA3033
        public static let discount = UIColor(red: 250.0/255.0, green: 48.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    }
    
    public struct Blue {
        
        public static let a = UIColor(red: 68.0/255.0, green: 116.0/255.0, blue: 177.0/255.0, alpha: 1.0)
        public static let b = UIColor(red: 69.0/255.0, green: 145.0/255.0, blue: 199.0/255.0, alpha: 1.0)
        public static let c = UIColor(red: 68.0/255.0, green: 195.0/255.0, blue: 234.0/255.0, alpha: 1.0)
        
        public static let facebook = UIColor(red: 44.0/255.0, green: 101.0/255.0, blue: 148.0/255.0, alpha: 1.0)
        public static let email = UIColor(red: 52.0/255.0, green: 96.0/255.0, blue: 164.0/255.0, alpha: 1.0)
        public static let discount = UIColor(red: 30.0/255.0, green: 230.0/255.0, blue: 129.0/255.0, alpha: 1.0)
    }
    
    public struct Gray {
        /// Hex: #949599
//        static let light = UIColor(hex: "#949599") //UIColor(red: 148.0, green: 149.0, blue: 153.0, alpha: 1.0)
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
