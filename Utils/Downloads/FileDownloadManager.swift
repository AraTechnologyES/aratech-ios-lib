//
//  FileDownloadManager.swift
//
//  Created by Nicolás Landa on 20/2/18.
//  Copyright © 2018 Nicolás Landa. All rights reserved.
//

import Foundation

public protocol BackgroundSessionEnabledApplicationDelegateProtocol {
	var backgroundSessionCompletionHandler: (() -> Void)? { get set }
}

public protocol ProgressUpdateDelegate {
	func updateDisplay(progress: Float, totalSize : String);
}

struct FileDownloadModel: Codable, Hashable {
	var hashValue: Int { return taskId }
	
	static func ==(lhs: FileDownloadModel, rhs: FileDownloadModel) -> Bool {
		return lhs.taskId == rhs.taskId
	}
	
	let sessionId: String
	let taskId: Int
	let filePath: String
	
	static func save(_ model: FileDownloadModel) { }
}

open class FileDownloadManager: NSObject {
	
	@objc static let shared: FileDownloadManager = FileDownloadManager()
	
	private static let cache: URLCache = {
		let cache = URLCache(memoryCapacity: 1024*1024*50, diskCapacity: 1024*1024*25, diskPath: "com.utils.FileDownloadManager")
		return cache
	}()
	
	private static let urlSessionConfiguration: URLSessionConfiguration = {
		let urlSessionConfiguration = URLSessionConfiguration.background(withIdentifier: "com.utils.FileDownloadManager")
		urlSessionConfiguration.requestCachePolicy = .returnCacheDataElseLoad
		urlSessionConfiguration.urlCache = cache
		return urlSessionConfiguration
	}()
	
	private static let urlSession: URLSession = {
		let urlSession = URLSession(configuration: urlSessionConfiguration, delegate: shared, delegateQueue: nil)
		return urlSession
	}()
	
	private var urlSession: URLSession {
		return type(of: self).urlSession
	}
	
	private lazy var encodedDownloadsUrl: URL = {
		return Sandbox.ApplicationSupport.downloads.appendingPathComponent("downloadingInBackground").appendingPathExtension("json")
	}()
	
	/// Conjunto de descargas pendientes
	private static var pendingDownloads: [Int: FileDownloadModel] = [:]
	
	/// Conjunto de delegados de progreso
	private static var progressDelegates: [Int: ProgressUpdateDelegate] = [:]
	
	/// Conjunto de operaciones de finalizado de descarga
	private static var completionOperations: [Int: Operation] = [:]
	private static let completionOperationQueue: OperationQueue = OperationQueue()
	
	// MARK: - Init
	
	private override init() { }
	
	// MARK: - API
	
	// MARK: Downloads
	
	/// Descarga el fichero especificado y lo guarda en la ruta local proporcionada.
	///
	/// - Parameters:
	///   - remoteUrl: url del fichero a descargar
	///   - localUrl: url en la que guardar el fichero (local)
	///   - progressDelegate: delegado para el progreso de la descarga, `nil` por defecto
	///   - completion: Bloque a ejecutar al terminar la descarga, `nil` por defecto
	/// - Returns: Operación Dummy por si se desea añadir la descarga como dependencia a otra operación
	@discardableResult
	public func download(file remoteUrl: URL,
						 into localUrl: URL,
						 progressDelegate: ProgressUpdateDelegate? = nil,
						 completion: (() -> ())? = nil) -> Operation {
		
		var urlRequest = URLRequest(url: remoteUrl)
		urlRequest.httpMethod = "GET"
		
		let downloadTask = self.urlSession.downloadTask(with: urlRequest)
		let taskId = downloadTask.taskIdentifier
		
		let fileDownloadModel = FileDownloadModel(sessionId: self.urlSession.configuration.identifier!,
												  taskId: taskId,
												  filePath: localUrl.path)
		
		type(of: self).pendingDownloads[taskId] = fileDownloadModel
		type(of: self).progressDelegates[taskId] = progressDelegate
		
		let operation = BlockOperation(block: completion ?? {
			Logger.shared.debug("Operación (dummy) de finalización de la tarea \(taskId) de descarga del fichero \(remoteUrl.absoluteString)")
		})
		type(of: self).completionOperations[taskId] = operation
		
		downloadTask.resume()
		
		return operation
	}
	
	// MARK: Background
	
	/// Prepara al gestor para seguir con las descargas mientras la app está en segundo plano
	@objc public func prepareForBackgroundActivity() {
		let downloadsToPersist: [FileDownloadModel] = type(of: self).pendingDownloads.values.map({ $0 })
		
		do {
			let fileManager = FileManager.default
			var url = self.encodedDownloadsUrl
			let encodedDownloads: Data = try JSONEncoder().encode(downloadsToPersist)
			
			// Crear ruta si no existe
			let directory = url.deletingLastPathComponent()
			if !fileManager.fileExists(atPath: directory.path) {
				try fileManager.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
			}
			
			// Eliminar si ya existe
			if fileManager.fileExists(atPath: url.path) {
				try fileManager.removeItem(at: url)
			}
			
			// Crear el fichero
			fileManager.createFile(atPath: url.path, contents: nil, attributes: nil)
			
			// No guardar en caso de copia de seguridad
			var resourceValues = URLResourceValues()
			resourceValues.isExcludedFromBackup = true
			try url.setResourceValues(resourceValues)
			
			// Guardar
			try encodedDownloads.write(to: url)
		} catch let error {
			Logger.shared.error("Ocurrión un error al codificar las descargas activas: \(error.localizedDescription)")
		}
	}
	
	/// Prepara al gestor para funcionar despues de que la app haya sido devuelta a primer plano
	@objc public func awakeFromBackground() {
		do {
			let data = try Data(contentsOf: self.encodedDownloadsUrl)
			let decoder = JSONDecoder()
			let downloads: [FileDownloadModel] = try decoder.decode([FileDownloadModel].self, from: data)
			
			downloads.forEach({ type(of: self).pendingDownloads[$0.taskId] = $0 })
			
		} catch let error {
			Logger.shared.error("Ocurrió un error al decodificar las descargas activas: \(error.localizedDescription)")
		}
	}
	
	// MARK: - Helpers
	
	private func save(file: URL, into url: URL) throws {
		let fileManager = FileManager.default
		
		// Crear ruta si no existe
		let directory = url.deletingLastPathComponent()
		if !fileManager.fileExists(atPath: directory.path) {
			try fileManager.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
		}
		
		// Eliminar si ya existe
		if fileManager.fileExists(atPath: url.path) {
			try fileManager.removeItem(at: url)
		}
		
		// Mover el nuevo archivo
		try fileManager.moveItem(atPath: file.path, toPath: url.path)
		
		Logger.shared.debug("Fichero \(file.lastPathComponent) copiado en \(url.deletingLastPathComponent())\n")
	}
}

extension FileDownloadManager: URLSessionDownloadDelegate {
	
	// MARK: - URLSessionDownloadDelegate
	
	public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
		guard let remoteUrl = downloadTask.originalRequest?.url else { return }
		Logger.shared.debug("Archivo \(remoteUrl.description) descargado en: \(location.path)")
		
		// Recoger el modelo, pues el delegado es compartido para todas las descargas
		guard let downloadFileModel = type(of: self).pendingDownloads[downloadTask.taskIdentifier] else { return }
		
		do {
			// Ahora toca guardarlo en una ubicación no temporal
			let fileURL = URL(fileURLWithPath: downloadFileModel.filePath)
			
			try self.save(file: location, into: fileURL)
			
			Logger.shared.debug("Emitida notificación para \(fileURL.path)")
			NotificationCenter.default.post(name: NSNotification.Name(rawValue: fileURL.path), object: fileURL)
			
			let taskId = downloadTask.taskIdentifier
			type(of: self).pendingDownloads.removeValue(forKey: taskId)
			type(of: self).progressDelegates.removeValue(forKey: taskId)
			
			if let completionOperation = type(of: self).completionOperations.removeValue(forKey: taskId) {
				Logger.shared.debug("Añadiendo operación de finalización para tarea: \(taskId)")
				type(of: self).completionOperationQueue.addOperation(completionOperation)
			}
		} catch {
			Logger.shared.error("Ocurrió un error al guardar el archivo \(remoteUrl.path) en \(downloadFileModel.filePath): \(error.localizedDescription)\n")
		}
	}
	
	public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
		guard let error = error,
			let remoteUrl = task.originalRequest?.url else { return }
		
		Logger.shared.error("Ocurrió un error descargando el archivo \(remoteUrl.path): \(error.localizedDescription)")
	}
	
	public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
		
		if totalBytesExpectedToWrite > 0 {
			// Recoger el delegado de progreso, pues el URLSessionDelegate es compartido para todas las descargas
			if let progressDelegate = type(of: self).progressDelegates[downloadTask.taskIdentifier] {
				let progress: Float = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
				let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: .file)
				progressDelegate.updateDisplay(progress: progress, totalSize: totalSize)
			}
		}
	}
	
	public func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
		DispatchQueue.main.async {
			if var appDelegate = UIApplication.shared.delegate as? BackgroundSessionEnabledApplicationDelegateProtocol {
				let completionHandler = appDelegate.backgroundSessionCompletionHandler
				appDelegate.backgroundSessionCompletionHandler = nil
				completionHandler?()
			}
		}
	}
}
