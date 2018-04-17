//
//  DelegatedCall.swift
//  https://medium.com/anysuggestion/preventing-memory-leaks-with-swift-compile-time-safety-49b845df4dc6
//
//  Created by Nicolás Landa on 17/4/18.
//  Copyright © 2018 Nicolás Landa. All rights reserved.
//

/**

Evita la aparición de fugas de memoria.

Ejemplo de utilización:

    class ImageDownloader {

	  var didDownload = DelegatedCall<UIImage>()

      func downloadImage(for url: URL) {
        download(url: url) { image in
          self.didDownload.callback?(image)
        }
	  }
	}

    class Controller {

      let downloader = ImageDownloader()
      var image: UIImage?

      init() {
        downloader.didDownload.delegate(to: self) { (self, image) in
          self.image = image
        }
      }

      func updateImage() {
        downloader.downloadImage(for: /* some image url */)
      }
    }
*/
public struct DelegatedCall<Input> {
	
	public typealias CallbackBlock = ((Input) -> Void)?
	private(set) public var callback: CallbackBlock
	
	public init() {
		self.callback = nil
	}
	
	/// Establece el callback
	///
	/// - Parameters:
	///   - object: Objeto a capturar
	///   - callback: Función a asignar al callback
	mutating public func delegate<Object: AnyObject>(to object: Object, with callback: @escaping (Object, Input) -> Void) {
		self.callback = { [weak object] input in
			guard let object = object else { return }
			callback(object, input)
		}
	}
}
