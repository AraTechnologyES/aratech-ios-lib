//
//  SelectableList.swift
//  Utils

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
        case (.selected,.notSelected):
            return .partial
        case (.notSelected,.selected):
            return .partial
        case (_,_):
            return .notSelected
        }
    }
}

public protocol Selectable {
    var state: SelectionState { get set }
}

/// Define una lista en la que cada nodo puede serlo a su vez, y que tiene definido su estado por el de sus hijos. La variable `state` ha de ser definida por quien implemente este protocolo, pero si es modificada directamente romperá el correcto funcionamiento de la lista, sin embargo puede ser observada ('didSet') para reaccionar a los cambios.
public protocol SelectableList: class, Selectable {
    
    /// No manipular directamente, usar metodos de la extensión.
    var state: SelectionState { get set }
    var items: [SelectableList] { get set }
    
    /// Descripción del elemento
    var itemDescription: String { get }
}

extension SelectableList {
    
    public var hasChilds: Bool {
        get {
            return self.items.count > 0
        }
    }
    
    public subscript(index: Int) -> SelectableList {
        get {
            return self.items[index]
        }
    }
    
    public subscript(filter: String) -> [SelectableList] {
        get {
            return self.items.filter({ (item) -> Bool in
                return item.itemDescription.localizedCaseInsensitiveContains(filter)
            })
        }
    }
    
    public func add(childList: [SelectableList]) {
        self.items = childList
    }
    
    public func append(child: SelectableList) {
        self.items.append(child)
    }
    
    public func getState() -> SelectionState {
        if items.count == 0 {
            // Si el elemento es 'hoja', se devuelve directamente su estado
            return self.state
        } else {
            // Si el elemento contiene items, se debe consultar el estado de ellos y combinar con el propio
            let itemsState = self.items.reduce(self.items[0].getState(), { (state, list) -> SelectionState in
                return state && list.getState()
            })
            
            self.state = itemsState
            
            return self.state
        }
    }
    
    public func set(state: SelectionState) {
        self.state = state
        
        for (index, _) in self.items.enumerated() {
            switch state {
            case .notSelected:
                self.set(child: index, state: .notSelected)
            case .selected:
                self.set(child: index, state: .selected)
            case .partial:
                // Si un elemento es seleccionado parcialmente, nada se hace con sus items
                break
            }
        }
    }
    
    public func set(child: Int, state: SelectionState) {
        self[child].set(state: state)
    }
}
