//
//  ImageAssets.swift
//  ATLibrary

import Foundation

//MARK:- Images assets

public protocol ImageAssetProvider {
    associatedtype ImageAssetName: RawRepresentable
}

extension ImageAssetProvider where ImageAssetName.RawValue == String {
    
    public static func image(forAsset asset: ImageAssetName, selected: Bool = false, renderingMode: UIImageRenderingMode? = nil) -> UIImage {
        let image = UIImage(named: selected ? asset.rawValue + "_selected" : asset.rawValue)!
        if renderingMode != nil { return image.withRenderingMode(renderingMode!) }
        return image
    }
    
    public static func imageView(forAsset asset: ImageAssetName, selected: Bool = false, tintColor: UIColor? = nil) -> UIImageView {
        let imageView: UIImageView!
        if let tintColor = tintColor {
            imageView = UIImageView(image: Self.image(forAsset: asset, selected: selected, renderingMode: .alwaysTemplate))
            imageView.tintColor = tintColor
        } else {
            imageView = UIImageView(image: Self.image(forAsset: asset, selected: selected))
        }
        return imageView
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
