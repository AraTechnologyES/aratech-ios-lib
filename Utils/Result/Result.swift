//
//  Result.swift
//  Utils
//
//  Created by Nicolás Landa on 17/4/18.
//  Copyright © 2018 Nicolás Landa. All rights reserved.
//

public enum Result<Value, ErrorType: Error> {
	case success(Value)
	case error(ErrorType)
}
