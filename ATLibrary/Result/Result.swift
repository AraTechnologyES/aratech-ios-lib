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
