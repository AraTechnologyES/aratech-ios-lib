//
//  ImageAssets.swift
//  Utils

import Foundation

//MARK:- Images assets

public protocol ImageAssetProvider {
    associatedtype ImageAssetName: RawRepresentable
    
    static func image(forAsset asset: ImageAssetName, selected: Bool) -> UIImage
}

extension ImageAssetProvider where ImageAssetName.RawValue == String {
    
    public static func image(forAsset asset: ImageAssetName, selected: Bool = false) -> UIImage {
        return UIImage(named: selected ? asset.rawValue + "_selected" : asset.rawValue)!
    }
    
    public static func imageView(forAsset asset: ImageAssetName, selected: Bool = false) -> UIImageView {
        return UIImageView(image: Self.image(forAsset: asset, selected: selected))
    }
}

// MARK:- Use Example

private struct UseExample: ImageAssetProvider {
    
    enum ImageAssetName: String {
        case example
    }
}

private func example() -> UIImage {
    return UseExample.image(forAsset: .example)
}

private func example() -> UIImageView {
    return UseExample.imageView(forAsset: .example)
}
