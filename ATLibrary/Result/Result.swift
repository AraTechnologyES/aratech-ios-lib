//
//  Result.swift
//  ATLibrary
//
//  Created by Nicolás Landa on 17/4/18.
//  
//

public enum Result<Value> {
	case success(Value)
	case error(Error)
}


// Referencia: https://appventure.me/2015/06/19/swift-try-catch-asynchronous-closures/

public typealias ThrowableResult<T> = () throws -> T
public typealias ThrowableCompletion<T> = (@escaping ThrowableResult<T>) -> Void
