//
//  ImageDownloaderTests.swift
//  ATLibraryTests
//
//  Created by Nicolás Landa on 18/4/18.
//  
//

import XCTest
@testable import ATLibrary
class ImageDownloaderTests: XCTestCase {
	
	let downloadableURL: URL = URL(string: "https://c24e867c169a525707e0-bfbd62e61283d807ee2359a795242ecb.ssl.cf3.rackcdn.com/imagenes/gato/etapas-clave-de-su-vida/gatitos/nuevo-gatito-en-casa/gatito-durmiendo-en-cama.jpg")!
	
	let downloader = ImageDownloader.shared
	
    func testSharedDownloaderDownloadsImage() {
		let testSharedDownloaderDownloadsImageExpectation = expectation(description: "testSharedDownloaderDownloadsImage")
		
		let imageView = UIImageView(image: nil)
		XCTAssertNil(imageView.image)

		downloader.download(downloadableURL, into: imageView, placeholder: nil, completion: BlockOperation(block: {
			testSharedDownloaderDownloadsImageExpectation.fulfill()
		}))
		
		waitForExpectations(timeout: 5.0, handler: nil)
		
		XCTAssertNotNil(imageView.image)
    }
	
	func testCompletionOperationCanAddDependencies() {
		let testCompletionOperationCanAddDependenciesExpectation = expectation(description: "testCompletionOperationCanAddDependencies")
		
		let completionOperation = BlockOperation {
			print("completionOperation")
		}
		
		let operationWithDependency = BlockOperation {
			testCompletionOperationCanAddDependenciesExpectation.fulfill()
		}
		
		operationWithDependency.addDependency(completionOperation)
		OperationQueue.main.addOperation(operationWithDependency)
		
		let imageView = UIImageView(image: nil)
		XCTAssertNil(imageView.image)
		
		downloader.download(downloadableURL, into: imageView, completion: completionOperation)
		
		waitForExpectations(timeout: 5.0, handler: nil)
		
		XCTAssertNotNil(imageView.image)
	}
	
	func testDownloadIsCancelled() {
		let testDownloadIsCancelledExpectation = expectation(description: "testDownloadIsCancelled")
		
		let imageView = UIImageView(image: nil)
		XCTAssertNil(imageView.image)
		
		downloader.download(downloadableURL, into: imageView)
		downloader.cancel(at: downloadableURL)
		
		execute(in: .main, delay: DispatchTime.now()+2.0) {
			testDownloadIsCancelledExpectation.fulfill()
		}
		
		waitForExpectations(timeout: 5.0, handler: nil)
		
		XCTAssertNil(imageView.image)
	}
}
