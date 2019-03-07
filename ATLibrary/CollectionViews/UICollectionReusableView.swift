//
//  UICollectionReusableView.swift
//  ATLibrary

import Foundation

extension UICollectionReusableView: NibCounterpartView { }

extension UICollectionReusableView: ReusableView { }

public extension Registrable where Self: UICollectionViewCell {
	static func register(in collectionView: UICollectionView) {
		collectionView.register(Self.self)
	}
}
