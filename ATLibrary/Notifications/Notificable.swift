//
//  Notificable.swift
//  ATLibrary

import Foundation

//MARK:- Notification's helper

public protocol NotificationNameProvider {
    associatedtype NotificationName: RawRepresentable
    
    static func add(observer: Any, selector: Selector, forNotification name: NotificationName, object: Any?)
    static func remove(observer: Any, forNotification name: NotificationName, object: Any?)
    static func post(notification name: NotificationName, object: Any?, userInfo: [AnyHashable : Any]?)
}

extension NotificationNameProvider where NotificationName.RawValue == String {
    
    public static func add(observer: Any, selector: Selector, forNotification name: NotificationName, object: Any? = nil) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name(name.rawValue), object: object)
    }
    
    public static func remove(observer: Any, forNotification name: NotificationName, object: Any? = nil) {
        NotificationCenter.default.removeObserver(observer, name: NSNotification.Name(name.rawValue), object: object)
    }
    
    public static func post(notification name: NotificationName, object: Any? = nil, userInfo: [AnyHashable : Any]? = nil) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: name.rawValue), object: object, userInfo: userInfo)
    }
}

// MARK:- Use Example

private struct MyNotifications: NotificationNameProvider {
    
    enum NotificationName: String {
        case example
    }
}

fileprivate class SomeoneObserving: Any {
    
    @objc func selectorFunction(){ }
}

private func example() {
    let someoneObserving = SomeoneObserving()
    
    MyNotifications.add(observer: someoneObserving, selector: #selector(someoneObserving.selectorFunction), forNotification: .example)
    
    MyNotifications.remove(observer: someoneObserving, forNotification: .example)
    
    MyNotifications.post(notification: .example)
}
