//
//  Logger.swift
//  Logger
//
//  Created by Nicolas Landa on 8/5/17.
//  Copyright © 2017 Nicolas Landa. All rights reserved.
//

import Foundation

public struct Logger {
	
	/// Instancia compartida configurada para debug
	public static let shared: Logger = {
		let logger = Logger(withLevel: .debug, mode: .debug)
		return logger
	}()
	
	internal static let dateFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		return dateFormatter
	}()
	
	/// Nivel de log
	public let severity: Severity
	/// Modo de la aplicación
	public let mode: AppMode
	
	private let showLevel: Bool
	private let showFileName: Bool
	private let showLineNumber: Bool
	
	///
	///
	/// - Parameters:
	///   - severity: Nivel del log
	///   - mode: Modo de la App, `nil` por defecto. Se autoconfigura con el flag 'DEBUG' del compilador si `nil`.
	///   - showLevel: Si ha de mostrarse el nivel de log
	///   - showFileNames: Si ha de mostrarse el nombre del fichero
	///   - showLineNumbers: Si ha de mostrarse el número de línea
	public init(withLevel severity: Severity, mode: AppMode? = nil, showLevel: Bool = true, showFileNames: Bool = true, showLineNumbers: Bool = true) {
		self.severity = severity
		
		if mode == nil {
			#if DEBUG
				self.mode = .debug
			#else
				self.mode = .release
			#endif
		} else {
			self.mode = mode!
		}
		
		self.showLevel = showLevel
		self.showFileName = showFileNames
		self.showLineNumber = showLineNumbers
	}
	
	// MARK:- API
	
	/// Función de ayuda, registra en el log con nivel **debug**<`info`
	public func debug(_ text: String, evenInReleaseMode writeAnyways: Bool = false, sourceFile fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) {
		self.log(text, in: .debug, evenInReleaseMode: writeAnyways, sourceFile: fileName, functionName: functionName, lineNumber: lineNumber)
	}
	
	/// Función de ayuda, registra en el log con nivel `debug`<**info**<`notice`
	public func info(_ text: String, evenInReleaseMode writeAnyways: Bool = false, sourceFile fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) {
		self.log(text, in: .info, evenInReleaseMode: writeAnyways, sourceFile: fileName, functionName: functionName, lineNumber: lineNumber)
	}
	
	/// Función de ayuda, registra en el log con nivel `info`<**notice**<`warning`
	public func notice(_ text: String, evenInReleaseMode writeAnyways: Bool = false, sourceFile fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) {
		self.log(text, in: .notice, evenInReleaseMode: writeAnyways, sourceFile: fileName, functionName: functionName, lineNumber: lineNumber)
	}
	
	/// Función de ayuda, registra en el log con nivel `notice`<**warning**<`error`
	public func warning(_ text: String, evenInReleaseMode writeAnyways: Bool = false, sourceFile fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) {
		self.log(text, in: .warning, evenInReleaseMode: writeAnyways, sourceFile: fileName, functionName: functionName, lineNumber: lineNumber)
	}
	
	/// Función de ayuda, registra en el log con nivel `warning`<**error**
	public func error(_ text: String, evenInReleaseMode writeAnyways: Bool = false, sourceFile fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) {
		self.log(text, in: .error, evenInReleaseMode: writeAnyways, sourceFile: fileName, functionName: functionName, lineNumber: lineNumber)
	}
	
	/// Registra el error en el log con nivel `warning`<**error**
	public func error(error: Error) {
		self.error(error.localizedDescription)
	}
	
	/// Registra en el log el texto especificado. Si no se concreta el nivel de log, se tomará el utilizado al instanciar la clase.
	///
	/// - Parameters:
	///   - text: Texto a registrar
	///   - severity: Nivel de log: `debug`<`ìnfo`<`notice`<`warning`<`error`
	///   - writeAnyways: Si ha de escribirse aunque no se esté en modo debug
	///   - fileName: Nombre del archivo que ejecuta este método
	///   - functionName: Nombre de la función que ejecuta este método
	///   - lineNumber: Número de linea del fichero donde está la función que ejecuta este método
	public func log(_ text: String, in severity: Severity? = nil, evenInReleaseMode writeAnyways: Bool = false, sourceFile fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) {
		var severity = severity
		if severity == nil { severity = self.severity }
		
		if shouldWrite(inSeverityLevel: severity!, evenInReleaseMode: writeAnyways) {
			self.write(text, sourceFile: fileName, functionName: functionName, lineNumber: lineNumber)
		}
	}
	
	// MARK:- Internal
	
	/// Escribe el log
	///
	/// - Parameter text: Texto a escribir
	internal func write(_ text: String, sourceFile fileName: String, functionName: String, lineNumber: Int) {
		NSLog(self.formatOutput(text: text, sourceFile: fileName, functionName: functionName, lineNumber: lineNumber))
	}
	
	/// Establece las condiciones para que un mensaje sea escrito en el log
	///
	/// - Parameters:
	///   - severity: Nivel del log
	///   - writeAnyways: Si ha de escribirse independientemente del modo de la app
	/// - Returns: Si el mensaje ha de ser escrito
	internal func shouldWrite(inSeverityLevel severity: Severity, evenInReleaseMode writeAnyways: Bool) -> Bool {
		if severity.rawValue >= self.severity.rawValue {
			
			if writeAnyways || self.mode == .debug {
				return true
			}
		}
		
		return false
	}
	
	/// Crea el String a escribir
	///
	/// - Parameters:
	///   - text: Texto
	///   - fileName: Nombre del archivo
	///   - functionName: Nombre de la función
	///   - lineNumber: Línea
	/// - Returns: El string listo para pintar
	internal func formatOutput(text: String, sourceFile fileName: String, functionName: String, lineNumber: Int) -> String {
		let className = (fileName as NSString).lastPathComponent
		
		var output = "\(Logger.dateFormatter.string(from: Date()))"
		
		output += self.showLevel ? " [\(self.severity.description)]" : ""
		output += " [\(functionName.components(separatedBy: "(")[0])]"
		output += self.showFileName ? " [\(className)" : ""
		output += self.showLineNumber ? ":\(lineNumber)]|" : "]|"
		
		return "\(output) \(text)"
	}
}
