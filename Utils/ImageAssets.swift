//
//  ImageAssets.swift
//  Utils

import Foundation

//MARK:- Images assets

public enum Icon : String {
    case imageAssetName
    case CheckBox
    case CheckBoxPartial
    case blue
    case clear
    case wallet
    case kapital
    case kapitalLogo
    case tickets
    
    public func image(selected: Bool = false) -> UIImage {
        return UIImage(named: selected ? self.rawValue + "_selected" : self.rawValue)!
    }
}
