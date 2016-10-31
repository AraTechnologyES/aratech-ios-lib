//
//  Notificable.swift
//  Utils

import Foundation

//MARK:- Notification's helper

public protocol Notificable {
    /// Notification identifiers
    associatedtype NotificationIdentifier: RawRepresentable
}

public extension Notificable where NotificationIdentifier.RawValue == String {
    func addObserver(_ observer: AnyObject, selector: Selector, forNotification notificationIdentifier: NotificationIdentifier, object: AnyObject) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: notificationIdentifier.rawValue), object: object)
    }
}
