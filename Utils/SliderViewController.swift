//
//  SliderViewController.swift
//  Utils

import UIKit

/// Implementa un slider o galería de imágenes paginada. Para Instanciar usando esta librería mediante Cocoapods:
///
///     let podBundle = Bundle(for: SliderViewController.self)
///     let bundleURL = podBundle.url(forResource: "Utils", withExtension: "bundle")
///     let bundle = Bundle(url: bundleURL!)
///     let slider = SliderViewController(nibName: "SliderViewController", bundle: bundle)
///
open class SliderViewController: UIViewController {
    
    /// Imágenes a mostrar
    public var images: [UIImage] = [] {
        didSet {
            self.setImagesInScrollView()
        }
    }
    
    /// Modo de las imágenes
    public var contentMode: UIViewContentMode = .scaleToFill
	
	public enum Position {
		case top
		case bottom
	}
	
	/// Posición del `pageControl`, abajo por defecto
	public var pageControlPosition: Position = .bottom {
		didSet {
			self.pageControlBottomConstraint?.isActive = self.pageControlPosition == .bottom
			self.pageControlTopConstraint?.isActive = self.pageControlPosition == .top
		}
	}
	
    /// Vistas suplementarias en cada página
    public var supplementaryViews: [Int:[UIView]] = [:] {
        didSet {
            self.setSupplementaryViews()
        }
    }
    
    /// Acción a ejecutar al pasar de página
    public var onPageChangeAction: ((_ newPage: Int)->Void)?
    
    private var pageWidth: CGFloat {
        return self.scrollView.bounds.width
    }
	
    // MARK:- IBOutlets
    
    @IBOutlet fileprivate weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl! {
        didSet {
            pageControl.hidesForSinglePage = true
        }
    }
	
	// MARK:- IBConstraints
	
	var pageControlTopConstraint: NSLayoutConstraint!
	var pageControlBottomConstraint: NSLayoutConstraint!
	var pageControlCenterConstraint: NSLayoutConstraint!
    
    // MARK:- Private
	
	fileprivate func setUpConstraints() {
		
		guard self.pageControl != nil, self.scrollView != nil else { return }
		
		self.pageControl.constraints.forEach({ $0.isActive = false })
		
		self.pageControlTopConstraint = NSLayoutConstraint(item: self.pageControl, attribute: .top, relatedBy: .equal, toItem: self.scrollView, attribute: .top, multiplier: 1.0, constant: 20.0)
		self.pageControlTopConstraint.isActive = self.pageControlPosition == .top
		
		self.pageControlBottomConstraint = NSLayoutConstraint(item: self.pageControl, attribute: .bottom, relatedBy: .equal, toItem: self.scrollView, attribute: .bottom, multiplier: 1.0, constant: -20.0)
		self.pageControlBottomConstraint.isActive = self.pageControlPosition == .bottom

		self.pageControlCenterConstraint = NSLayoutConstraint(item: self.pageControl, attribute: .centerX, relatedBy: .equal, toItem: self.scrollView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
		self.pageControlCenterConstraint.isActive = true
	}
    
    fileprivate func setImagesInScrollView() {
		
        guard (self.scrollView) != nil else { return }
		
		DispatchQueue.main.async {
			
			self.scrollView.subviews.forEach { $0.removeFromSuperview() }
			
			for (index,image) in self.images.enumerated() {
				let imageView = UIImageView(frame: CGRect(x: CGFloat(index)*self.scrollView.frame.width, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height))
				imageView.image = image
				imageView.contentMode = self.contentMode
				imageView.clipsToBounds = true
				self.scrollView.addSubview(imageView)
			}
			
			self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width*CGFloat(self.images.count), height: self.scrollView.frame.height)
			
			self.pageControl.numberOfPages = self.images.count

		}
		
	}
	
	// MARK:- API
	
	public func scroll(toPage page: Int, animated: Bool = false) {
		self.scrollView.scrollRectToVisible(CGRect(x: 1+(self.pageWidth*CGFloat(page)), y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height), animated: animated)
	}
	
    func setSupplementaryViews() {
        
        guard (self.scrollView) != nil else { return }
        
        // Eliminar todas las vistas que no sean imageView
        self.scrollView.subviews.forEach { view in
            if !(view is UIImageView) {
                view.removeFromSuperview()
            }
        }
        
        for (page,views) in self.supplementaryViews {
            if page < self.images.count {
                
                let pageOrigin = CGPoint(x: self.scrollView.frame.width*CGFloat(page), y: 0)
                for view in views {
                    let newViewOrigin = CGPoint(x: view.frame.origin.x+pageOrigin.x, y: view.frame.origin.y)
                    view.frame.origin = newViewOrigin
                    self.scrollView.addSubview(view)
                }
            }
        }
    }
	
    // MARK:- Life Cicle
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.scrollView?.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height)
		
		self.setUpConstraints()
        self.setImagesInScrollView()
        self.setSupplementaryViews()
    }
}

extension SliderViewController: UIScrollViewDelegate {
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth: CGFloat = self.scrollView.bounds.width
        let currentPage: CGFloat = floor((self.scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage);
        
        self.onPageChangeAction?(self.pageControl.currentPage)
    }
}
