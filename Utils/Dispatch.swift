//
//  Dispatch.swift
//  Utils
//
//  Created by Aratech iOS on 8/9/17.
//  Copyright © 2017 AraTech. All rights reserved.
//

/// Ejecuta el bloque en la cola especificada
///
/// - Parameters:
///   - queue: Cola donde ejecutar el bloque
///   - delay: Si se desea un retraso en la ejecución
///   - closure: Bloque a ejecutar
public func execute(in queue: DispatchQueue, delay: DispatchTime? = nil, _ closure: @escaping ()->Void) {
	
	if let delay = delay {
		// Si hay delay no queda otra que mandarlo a la cola, aunque sea la actual
		queue.asyncAfter(deadline: delay, execute: closure)
	} else {
		if Thread.current == queue {
			closure()
		} else {
			queue.async {
				closure()
			}
		}
	}
}
