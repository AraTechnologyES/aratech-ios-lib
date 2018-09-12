/*

Fuente: https://developer.apple.com/documentation/uikit/uicollectionviewdatasourceprefetching/prefetching_collection_view_data

*/

import Foundation

/// - Tag: AsyncImageFetcher
open class AsyncImageFetcher {
	
	/// Alias para UIImage
	public typealias DisplayData = UIImage
	/// Alias para URL
	public typealias UUID = URL
	
    // MARK: Types

    /// A serial `OperationQueue` to lock access to the `fetchQueue` and `completionHandlers` properties.
    private let serialAccessQueue = OperationQueue()

    /// An `Set` that contains `URLSessionDataTask`s for requested data.
	private var fetchTasks: Set<URLSessionDataTask> = Set<URLSessionDataTask>()

    /// A dictionary of arrays of closures to call when an object has been fetched for an id.
    private var completionHandlers = [UUID: [(DisplayData?) -> Void]]()

    /// An `NSCache` used to store fetched objects.
    private var cache = NSCache<NSURL, DisplayData>()

	private let urlSession: URLSession
	
	private static let sharedUrlCache: URLCache =
		URLCache(memoryCapacity: 1024*1024*50, diskCapacity: 1024*1024*25, diskPath: "com.aratech.atlibrary.AsyncImageFetcher")
	
    // MARK: Initialization

	public init() {
		
		let urlSessionConfiguration: URLSessionConfiguration = {
			let urlSessionConfiguration = URLSessionConfiguration.default
			urlSessionConfiguration.requestCachePolicy = .returnCacheDataElseLoad
			urlSessionConfiguration.urlCache = AsyncImageFetcher.sharedUrlCache
			return urlSessionConfiguration
		}()
		
		urlSession = URLSession(configuration: urlSessionConfiguration, delegate: nil, delegateQueue: nil)
		
        serialAccessQueue.maxConcurrentOperationCount = 1
    }

    // MARK: Object fetching

    /**
     Asynchronously fetches data for a specified `UUID`.
     
     - Parameters:
         - identifier: The `UUID` to fetch data for.
         - completion: An optional called when the data has been fetched.
    */
    public func fetchAsync(_ identifier: UUID, completion: ((DisplayData?) -> Void)? = nil) {
        // Use the serial queue while we access the fetch queue and completion handlers.
        serialAccessQueue.addOperation {
            // If a completion block has been provided, store it.
            if let completion = completion {
                let handlers = self.completionHandlers[identifier, default: []]
                self.completionHandlers[identifier] = handlers + [completion]
            }
            
            self.fetchData(for: identifier)
        }
    }

    /**
     Returns the previously fetched data for a specified `UUID`.
     
     - Parameter identifier: The `UUID` of the object to return.
     - Returns: The 'DisplayData' that has previously been fetched or nil.
     */
    public func fetchedData(for identifier: UUID) -> DisplayData? {
        return cache.object(forKey: identifier as NSURL)
    }

    /**
     Cancels any enqueued asychronous fetches for a specified `UUID`. Completion
     handlers are not called if a fetch is canceled.
     
     - Parameter identifier: The `UUID` to cancel fetches for.
     */
    public func cancelFetch(_ identifier: UUID) {
        serialAccessQueue.addOperation {
            self.operation(for: identifier)?.cancel()
            self.completionHandlers[identifier] = nil
        }
    }

    // MARK: Convenience
    
    /**
     Begins fetching data for the provided `identifier` invoking the associated
     completion handler when complete.
     
     - Parameter identifier: The `UUID` to fetch data for.
     */
    private func fetchData(for identifier: UUID) {
        // If a request has already been made for the object, do nothing more.
		if self.cache.object(forKey: identifier as NSURL) != nil {
			return
		} else if let dataTask = operation(for: identifier) {
			self.fetchTasks.remove(dataTask)
		}
        
        if let data = fetchedData(for: identifier) {
            // The object has already been cached; call the completion handler with that object.
            invokeCompletionHandlers(for: identifier, with: data)
        } else {
            // Enqueue a request for the object.
			let urlRequest = URLRequest(url: identifier)
			let dataTask = self.urlSession.dataTask(with: urlRequest) { (data, response, error) in
				guard let fetchedData = data else { return }
				guard let fetchedImage = UIImage(data: fetchedData) else { return }
				
				self.cache.setObject(fetchedImage, forKey: identifier as NSURL)
				
				self.serialAccessQueue.addOperation {
					self.invokeCompletionHandlers(for: identifier, with: fetchedImage)
				}
			}
			
			dataTask.resume()
			
			self.fetchTasks.insert(dataTask)
        }
    }

    /**
     Returns any enqueued `URLSessionDataTask` for a specified `UUID`.
     
     - Parameter identifier: The `UUID` of the operation to return.
     - Returns: The enqueued `URLSessionDataTask` or nil.
     */
    private func operation(for identifier: UUID) -> URLSessionDataTask? {
		for dataTask in fetchTasks.filter({ $0.originalRequest?.url == identifier }) {
			return dataTask
		}
		
        return nil
    }

    /**
     Invokes any completion handlers for a specified `UUID`. Once called,
     the stored array of completion handlers for the `UUID` is cleared.
     
     - Parameters:
     - identifier: The `UUID` of the completion handlers to call.
     - object: The fetched object to pass when calling a completion handler.
     */
    private func invokeCompletionHandlers(for identifier: UUID, with fetchedData: DisplayData) {
        let completionHandlers = self.completionHandlers[identifier, default: []]
        self.completionHandlers[identifier] = nil

        for completionHandler in completionHandlers {
            completionHandler(fetchedData)
        }
    }
}
