//
//  SelectableList.swift
//  Tests
//
//  Created by Aratech iOS on 25/1/17.
//  Copyright © 2017 AraTech. All rights reserved.
//

import Foundation

/// Posibles estados de selección
///
/// - selected:   Seleccionado
/// - partial:    Seleccionado parcialmente
/// - noSelected: No seleccionado

public enum SelectionState {
    case selected
    case partial
    case notSelected
    
    /// Comparación de elementos
    ///
    /// - Returns: Seleccionado si ambos lo estan, parcial si cualquiera de ellos lo es, no seleccionado en otro caso.
    static func && (left: SelectionState, right: SelectionState) -> SelectionState {
        switch (left,right) {
        case (.selected,.selected):
            return .selected
        case (.partial,_):
            return .partial
        case (_,.partial):
            return .partial
        case (_,_):
            return .notSelected
        }
    }
}

protocol Selectable {
    var state: SelectionState { get set }
}

/// Define una lista en la que cada nodo puede serlo a su vez, y que tiene definido su estado por el de sus hijos. La variable `state` ha de ser definida por quien implemente este protocolo, pero si es modificada directamente romperá el correcto funcionamiento de la lista, sin embargo puede ser observada ('didSet') para reaccionar a los cambios.
protocol SelectableList: class, Selectable {
    var isStateUpdated: Bool { get set }
    
    /// No manipular directamente, usar metodos de la extensión.
    var state: SelectionState { get set }
    var items: [SelectableList] { get }
}

extension SelectableList {
    
    subscript(index: Int) -> Selectable {
        get {
            return self.items[index]
        }
    }
    
    func getState() -> SelectionState {
        if self.isStateUpdated {
            // El estado del elemento es el correcto, no hace falta buscar
            return self.state
        } else {
            if items.count == 0 {
                // Si el elemento es 'hoja', se devuelve directamente su estado
                self.isStateUpdated = true
                return self.state
            } else {
                // Si el elemento contiene items, se debe consultar el estado de ellos y combinar con el propio
                let itemsState = self.items.reduce(.selected, { (state, list) -> SelectionState in
                    return state && list.getState()
                })
                
                self.state = itemsState && self.state
                self.isStateUpdated = true
                
                return self.state
            }
        }
    }
    
    func setState(state: SelectionState) {
        self.isStateUpdated = false
        
        self.state = state
        
        switch state {
        case .notSelected:
            self.items.forEach { $0.setState(state: .notSelected) }
        case .selected:
            self.items.forEach { $0.setState(state: .selected) }
        case .partial:
            // Si un elemento es seleccionado parcialmente, nada se hace con sus items
            break
        }
    }
}
