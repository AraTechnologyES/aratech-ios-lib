//
//  UICollectionReusableView.swift
//  Utils

import Foundation

extension UICollectionReusableView: NibLoadableView { }

extension UICollectionReusableView: ReusableView { }

public extension Registrable where Self: UICollectionViewCell {
	static func register(in collectionView: UICollectionView) {
		collectionView.register(Self.self)
	}
}
