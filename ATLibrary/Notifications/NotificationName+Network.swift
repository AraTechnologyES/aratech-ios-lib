//
//  NotificationName+Network.swift
//  ATLibrary
//
//  Created by Nicolás Landa on 09/01/2019.
//  
//

public extension Notification {
	
	/// Notification corresponding to `networkActivityStarted` string
	public static let networkActivityStarted: Notification = Notification(name: .networkActivityStarted)
	
	/// Notification corresponding to `networkActivityFinished` string
	public static let networkActivityFinished: Notification = Notification(name: .networkActivityFinished)
}

public extension NSNotification.Name {
	
	/// Network activity started
	public static let networkActivityStarted: NSNotification.Name = NSNotification.Name(rawValue: "networkActivityStarted")
	
	/// Network activity finished
	public static let networkActivityFinished: NSNotification.Name = NSNotification.Name(rawValue: "networkActivityFinished")
}
