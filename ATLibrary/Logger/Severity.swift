//
//  Severity.swift
//  ATLogger
//
//  Created by Nicolas Landa on 8/5/17.
//  
//

import Foundation

/// Niveles de error del log:
///
/// - `debug`: Debug-level messages
/// - `info`: Informational messages
/// - `notice`: Normal but significant conditions
/// - `warning`: Warning conditions
/// - `error`: Error conditions
public enum Severity: Int, CustomStringConvertible {
	/// **debug**<`info`
	case debug
	/// `debug`<**info**<`notice`
	case info
	/// `info`<**notice**<`warning`
	case notice
	/// `notice`<**warning**<`error`
	case warning
	/// `warning`<**error**
	case error
	
	public var description: String {
		switch self {
		case .debug:
			return "DEBUG"
		case .info:
			return "INFO"
		case .notice:
			return "NOTICE"
		case .warning:
			return "WARNING"
		case .error:
			return "ERROR"
		}
	}
}
