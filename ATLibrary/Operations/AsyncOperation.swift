//
//  ConcurrentOperation.swift
//
//  Created by Nicolás Landa on 21/2/18.
//  
//

import Foundation

/// Clase base para operaciones concurrentes/asíncronas.
///
/// Sobreescribir método `main` para personalizar comportamiento. Asignar .finished a `state` para dar por finalizada la operación:
///
///     self.status = .finished
///
open class AsyncOperation: Operation {
	
	public enum State: String {
		case ready = "Ready"
		case executing = "Executing"
		case finished = "Finished"
		
		fileprivate var keyPath: String {
			return "is" + rawValue
		}
	}
	
	override open var isAsynchronous: Bool { return true }
	
	override open var isReady: Bool { return super.isReady && self.state == .ready }
	override open var isExecuting: Bool { return self.state == .executing }
	override open var isFinished: Bool { return self.state == .finished }
	
	public final var state: State = .ready {
		willSet {
			willChangeValue(forKey: newValue.keyPath)
			willChangeValue(forKey: state.keyPath)
		} didSet {
			didChangeValue(forKey: oldValue.keyPath)
			didChangeValue(forKey: state.keyPath)
		}
	}
	
	override open func start() {
		if self.isCancelled {
			self.state = .finished
			return
		}
		
		self.main()
		self.state = .executing
	}
	
	override open func cancel() {
		self.state = .finished
	}
}
