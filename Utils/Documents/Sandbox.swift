//
//  Sandbox.swift
//  Utils


import Foundation

// MARK:- Sandbox
public struct Sandbox {
    /// Document's directory of app
    public static let Documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    public static let Library = try! FileManager.default.url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
	
	/**
	Directorio para datos de soporte de la aplicación, su contenido es respaldado en iCloud.
	
	[File System Programming Guide]:
	https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html#//apple_ref/doc/uid/TP40010672-CH2-SW1
	
	Para más información sobre el sistema de archivos [File System Programming Guide].
	
	*/
	public struct ApplicationSupport {
		/// Raiz del directorio de soporte
		public static var root: URL {
			let appBundleID = Bundle.main.bundleIdentifier!
			return try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(appBundleID, isDirectory: true)
		}
	}
}
