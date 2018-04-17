//
//  ConcurrentOperation.swift
//
//  Created by Nicolás Landa on 21/2/18.
//  
//

import Foundation

/// Clase base para operaciones concurrentes. Solo es necesario llamar a la función `finish` al terminar el trabajo en `start`
class AsyncOperation: Operation {
	
	public struct Queues {
		public static let userInitiated: OperationQueue = {
			let queue = OperationQueue()
			queue.name = "AsyncOperation.Queues.userIniciated"
			queue.qualityOfService = .userInitiated
			return queue
		}()
		
		public static let utility: OperationQueue = {
			let queue = OperationQueue()
			queue.name = "AsyncOperation.Queues.utility"
			queue.qualityOfService = .utility
			return queue
		}()
	}
	
	enum State: String {
		case ready = "Ready"
		case executing = "Executing"
		case finished = "Finished"
		
		fileprivate var keyPath: String {
			return "is" + rawValue
		}
	}
	
	override var isAsynchronous: Bool { return true }
	
	override var isReady: Bool { return super.isReady && self.state == .ready }
	override var isExecuting: Bool { return self.state == .executing }
	override var isFinished: Bool { return self.state == .finished }
	
	var state: State = .ready {
		willSet {
			willChangeValue(forKey: newValue.keyPath)
			willChangeValue(forKey: state.keyPath)
		} didSet {
			didChangeValue(forKey: oldValue.keyPath)
			didChangeValue(forKey: state.keyPath)
		}
	}
	
	override func start() {
		if self.isCancelled {
			self.state = .finished
			return
		}
		
		self.main()
		self.state = .executing
	}
	
	override func cancel() {
		self.state = .finished
	}
}
