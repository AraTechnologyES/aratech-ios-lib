//
//  ImageAssets.swift
//  Utils

import Foundation

//MARK:- Images assets

public enum Icon : String {
    case imageAssetName
    case CheckBox
    case CheckBoxPartial
    
    func image(selected: Bool = false) -> UIImage {
        return UIImage(named: selected ? self.rawValue + "_selected" : self.rawValue)!
    }
}
