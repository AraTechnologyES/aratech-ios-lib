//
//  SliderViewController.swift
//  Utils

import UIKit

/// Implementa un slider o galería de imágenes paginada
open class SliderViewController: UIViewController {
    
    /// Imágenes a mostrar
    public var images: [UIImage] = [] {
        didSet {
            self.setImagesInScrollView()
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
    
    // MARK:- IBOutlets
    
    @IBOutlet fileprivate weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK:- Private
    
    fileprivate func setImagesInScrollView() {
    
        guard (self.scrollView) != nil else { return }
        
        self.scrollView.subviews.forEach { $0.removeFromSuperview() }
        
        for (index,image) in images.enumerated() {
            let imageView = UIImageView(frame: CGRect(x: CGFloat(index)*self.scrollView.frame.width, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height))
            imageView.image = image
            self.scrollView.addSubview(imageView)
        }
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width*CGFloat(images.count), height: self.scrollView.frame.height)
        
        self.pageControl.numberOfPages = self.images.count
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
        
        self.scrollView.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height)
        
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
