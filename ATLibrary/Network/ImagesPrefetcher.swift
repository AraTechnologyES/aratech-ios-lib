//
//  ImagesPrefetcher.swift
//

import CoreData

public protocol ImageURLHolder {
	var imageURLKeyPath: KeyPath<Self, URL> { get }
}

open class ImagesPrefetcher<Model: NSManagedObject>: NSObject where Model: ImageURLHolder {
	
	private let imageFetcher: AsyncImageFetcher
	private let resultsController: NSFetchedResultsController<Model>
	
	public init(imageFetcher: AsyncImageFetcher, resultsController: NSFetchedResultsController<Model>) {
		self.imageFetcher = imageFetcher
		self.resultsController = resultsController
	}
	
	func prefetch(at indexPaths: [IndexPath]) {
		for indexPath in indexPaths {
			let object = resultsController.object(at: indexPath)
			imageFetcher.fetchAsync(object[keyPath: object.imageURLKeyPath])
		}
	}
	
	func cancelPrefetch(at indexPaths: [IndexPath]) {
		for indexPath in indexPaths {
			let object = resultsController.object(at: indexPath)
			imageFetcher.cancelFetch(object[keyPath: object.imageURLKeyPath])
		}
	}
}

open class TableViewImagesPrefetcher<Model: NSManagedObject>: ImagesPrefetcher<Model>, UITableViewDataSourcePrefetching where Model: ImageURLHolder {
	
	public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
		prefetch(at: indexPaths)
	}

	public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
		cancelPrefetch(at: indexPaths)
	}
}

open class CollectionViewImagesPrefetcher<Model: NSManagedObject>: ImagesPrefetcher<Model>, UICollectionViewDataSourcePrefetching where Model: ImageURLHolder {
	
	public func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
		prefetch(at: indexPaths)
	}
	
	public func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
		cancelPrefetch(at: indexPaths)
	}
}
