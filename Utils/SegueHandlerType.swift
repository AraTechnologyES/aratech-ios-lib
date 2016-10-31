//
//  SegueHandlerType.swift
//  Utils

import Foundation

// MARK:- Segue's helper

protocol SegueHandlerType {
    /// Segues identifiers
    associatedtype SegueIdentifier: RawRepresentable
}

extension SegueHandlerType where Self: UIViewController, SegueIdentifier.RawValue == String {
    
    func performSegueWithIdentifier(_ segueIdentifier: SegueIdentifier, sender: AnyObject?) {
        performSegue(withIdentifier: segueIdentifier.rawValue, sender: sender)
    }
    
    func segueIdentifierForSegue(_ segue: UIStoryboardSegue) -> SegueIdentifier {
        guard let identifier = segue.identifier,
            let segueIdentifier = SegueIdentifier(rawValue: identifier) else {
                print("Invalid segue identifier \(segue.identifier).")
                fatalError("Invalid segue identifier \(segue.identifier).")
        }
        return segueIdentifier
    }
    
    func segueIdentifierForIdentifier(_ identifier: String) -> SegueIdentifier {
        guard let segueIdentifier = SegueIdentifier(rawValue: identifier) else {
            print("Invalid segue identifier \(identifier).")
            fatalError("Invalid segue identifier \(identifier).")
        }
        return segueIdentifier
    }
}
