//
//  Stylable.swift
//  ATLibrary
//
//  Created by Nicolás Landa on 07/03/2019.
//  

/**

View style represented by a configuration closure

Usage example:

```
extension ViewStyle where T: UIButton {

  static var filled: ViewStyle<UIButton> {
    return ViewStyle<UIButton> {
	  $0.setTitleColor(.white, for: .normal)
	  $0.backgroundColor = .red
    }
  }

  static var rounded: ViewStyle<UIButton> {
    return ViewStyle<UIButton> {
      $0.layer.cornerRadius = 4.0
    }
  }

  static var roundedAndFilled: ViewStyle<UIButton> {
    return filled.compose(with: rounded)
  }
}
```

*/
public struct ViewStyle<T> {
	let style: (T) -> Void
	
	public init(style: @escaping (T) -> Void) {
		self.style = style
	}
}

public extension ViewStyle {
	
	public func compose(with style: ViewStyle<T>) -> ViewStyle<T> {
		return ViewStyle<T> {
			self.style($0)
			style.style($0)
		}
	}
}

public func style<T>(_ object: T, with style: ViewStyle<T>) {
	style.style(object)
}

/**

Stylable initializer

Usage example:

```
let button = UIButton(style: .rounded)
```

*/
public protocol Stylable {
	init()
}

extension UIView: Stylable {}

public extension Stylable {
	
	public init(style: ViewStyle<Self>) {
		self.init()
		apply(style)
	}
	
	public func apply(_ style: ViewStyle<Self>) {
		style.style(self)
	}
}
