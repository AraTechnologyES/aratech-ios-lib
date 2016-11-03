//
//  EditListViewControllerViewModel.swift


import UIKit

/// Posibles estados para una seleccion que contiene elementos internos, que a su vez pueden ser seleccionables
///
/// - selected:   Seleccionados todos los elementos internos
/// - partial:    Parcialmente seleccionados los elementos internos
/// - noSelected: Ningun elemento interno seleccionado

public enum SelectionType {
    case selected
    case partial
    case noSelected
    
    
    /// La imagen que representa al estado
    public var image: UIImage {
        get {
            switch self {
            case .noSelected:
                return Icon.CheckBox.image()
            case .partial:
                return Icon.CheckBoxPartial.image()
            case .selected:
                return Icon.CheckBox.image(selected: true)
            }
        }
    }
}

/// Protocolo que define las propiedades que debe tener un item que pueda ser seleccionable, y cuyo estado esta definido por el tipo SelectionType. Si el elemento contiene sub elementos, su estado estara definido en funcion del de estos, es decir, si todos los sub elementos estan selecionados, se considera al elemento seleccionado.
public protocol Selectable {
    
    var id: String? { get }
    var name: String { get }
    var state: SelectionType { get set }
    
    var subComponents: [Selectable]? { get set }
}

public class SelectableListElement: Selectable {
    
    public var id: String?
    public var name: String
    private var selfState: SelectionType = .noSelected
    
    public var subComponents: [Selectable]?
    
    public var state: SelectionType {
        get {
            return self.determineState()
        }
        set {
            self.selfState = newValue
            self.setStateForSubComponents()
            
        }
    }
    
    public init(whitName name: String, id: String? = nil, state: SelectionType, subComponents: [Selectable]? = nil) {
        self.id = id
        self.name = name
        self.selfState = state
        self.subComponents = subComponents
    }
    
    
    
    /// Genera un modelo para pruebas con el siguiente esquema:
    
    ///   ## Zonas
    
    /// - Zona1
    ///     - Categoria1
    ///         - SubCategoria1
    ///         - SubCategoria2
    ///     - Categoria2
    ///         - Subcategoria3
    ///         - Subcategoria4
    
    /// - Zona2
    ///     - Categoria3
    ///         - Subcategoria5
    ///         - Subcategoria6
    ///     - Categoria4
    ///         - Subcategoria7
    
    /// - Zona3
    ///     - Categoria5
    ///         - Subcategoria8
    ///
    /// - Zona4
    ///     - Categoria6
    ///
    static var mockups: [SelectableListElement] {
        let subcategoria1 = SelectableListElement(whitName: "Subcategoria 1",state: .noSelected)
        let subcategoria2 = SelectableListElement(whitName: "Subcategoria 2",state: .noSelected)
        let subcategoria3 = SelectableListElement(whitName: "Subcategoria 3",state: .noSelected)
        let subcategoria4 = SelectableListElement(whitName: "Subcategoria 4",state: .noSelected)
        let subcategoria5 = SelectableListElement(whitName: "Subcategoria 5",state: .noSelected)
        let subcategoria6 = SelectableListElement(whitName: "Subcategoria 6",state: .noSelected)
        let subcategoria7 = SelectableListElement(whitName: "Subcategoria 7",state: .noSelected)
        let subcategoria8 = SelectableListElement(whitName: "Subcategoria 8",state: .noSelected)
        let categoria1 = SelectableListElement(whitName: "Categoria 1",state: .noSelected, subComponents: [subcategoria1,subcategoria2])
        let categoria2 = SelectableListElement(whitName: "Categoria 2",state: .noSelected, subComponents: [subcategoria3,subcategoria4])
        let categoria3 = SelectableListElement(whitName: "Categoria 3",state: .noSelected, subComponents: [subcategoria5,subcategoria6])
        let categoria4 = SelectableListElement(whitName: "Categoria 4",state: .noSelected, subComponents: [subcategoria7])
        let categoria5 = SelectableListElement(whitName: "Categoria 5",state: .noSelected, subComponents: [subcategoria8])
        let categoria6 = SelectableListElement(whitName: "Categoria 6",state: .noSelected, subComponents: nil)
        let zona1 = SelectableListElement(whitName: "Zona 1",state: .noSelected, subComponents: [categoria1,categoria2])
        let zona2 = SelectableListElement(whitName: "Zona 2",state: .noSelected, subComponents: [categoria3,categoria4])
        let zona3 = SelectableListElement(whitName: "Zona 3",state: .noSelected, subComponents: [categoria5])
        let zona4 = SelectableListElement(whitName: "Zona 4",state: .noSelected, subComponents: [categoria6])
        return [zona1,zona2,zona3,zona4]
    }
    
    // MARK:- Private
    
    /// Calcula el estado del elemento en funcion de sus subelementos. En caso de no tenerlos, devuelve directamente el estado propio del elemento.
    ///
    /// - returns: El estado del elemento
    fileprivate func determineState() -> SelectionType {
        if subComponents != nil {
            // Buscar si todos los subcomponentes estan seleccionados o no, por defecto todo esta sin seleccionar
            var somethingNoSelected = false
            var somethingSelected = false
            for subComponent in subComponents! {
                switch subComponent.state {
                case .noSelected:
                    somethingNoSelected = true
                    if somethingSelected && somethingNoSelected { return .partial }
                case .selected:
                    somethingSelected = true
                    if somethingNoSelected && somethingSelected{ return .partial }
                case .partial:
                    return .partial
                }
            }
            if somethingNoSelected && !somethingSelected {
                return .noSelected
            } else {
                return .selected
            }
        } else {
            return self.selfState
        }
    }
    
    /// Establece el estado de los subcomponentes en funcion del propio
    fileprivate func setStateForSubComponents() {
        if self.subComponents != nil {
            switch self.selfState {
            case .selected:
                for index in 0..<self.subComponents!.count {
                    self.subComponents![index].state = .selected
                }
            case .noSelected:
                for index in 0..<self.subComponents!.count {
                    self.subComponents![index].state = .noSelected
                }
            case .partial:
                break
            }
        }
    }
}

public protocol SelectableListProtocol {
    
    var list: [Selectable] { get }
    
    subscript(index:Int) -> Selectable { get }
    
    subscript(id: String) -> Selectable? { get }
    
    func listElement(wasSelectedAt index: Int) -> SelectionType
    
    func filterList(forSearchText text: String)
    
    func childList(forIndex index: Int) -> SelectableListProtocol?
    
}

public class SelectableList: SelectableListProtocol {
    
    private var elements: [Selectable]
    private var filteredElements: [Selectable]?
    
    public subscript(index: Int) -> Selectable {
        get {
            return self.list[index]
        }
    }
    
    
    /// Devuelve el elemento de la lista cuyo id coincida con el proporcionado como parametro, de existir.
    ///
    /// - parameter id: El id del elemento deseado
    ///
    /// - returns: El elemento cuyo id coincida
    public subscript(id: String) -> Selectable? {
        get {
            for element in self.elements {
                if element.id == id { return element }
            }
            return nil
        }
    }
    
    public var list: [Selectable] {
        get {
            guard let filteredElements = filteredElements else { return elements }
            return filteredElements
        }
    }
    
    public init() {
        self.elements = SelectableListElement.mockups
        self.filteredElements = nil
    }
    
    public init(withElements elements: [Selectable]) {
        self.elements = elements
    }
    
    private func element(forIndex index: Int) -> Selectable {
        if self.filteredElements != nil {
            return self.filteredElements![index]
        } else {
            return self.elements[index]
        }
    }
    
    public func childList(forIndex index: Int) -> SelectableListProtocol? {
        let element = self.element(forIndex: index)
        
        guard let childs = element.subComponents else { return nil }
        return SelectableList(withElements: childs)
    }
    
    /// Establece el estado del elemento seleccionado
    ///
    /// - parameter index: El indice del elemento seleccionado
    ///
    /// - returns: El estado del elemento tras la seleccion
    public func listElement(wasSelectedAt index: Int) -> SelectionType {
        
        var element = self.element(forIndex: index)
        
        switch element.state {
        case .noSelected:
            element.state = .selected
        case .selected:
            element.state = .noSelected
        case .partial:
            element.state = .selected
        }
        return element.state
    }
    
    public func filterList(forSearchText text: String) {
        if text != "" {
            self.filteredElements = self.elements.filter { element in
                return element.name.lowercased().contains(text.lowercased())
            }
        } else if text == "" {
            self.filteredElements = nil
        }
        
    }
}
