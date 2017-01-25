//
//  FillableCircleView.swift
//  Utils

import UIKit

/// Vista rellenable
@IBDesignable open class FillableView: UIView {
    
    private var interiorView: UIView!
    
    private var interiorViewHeight: CGFloat {
        return self.frame.height - self.borderWidth*2 - self.margin
    }
    
    // MARK:- API
    
    /// Si los cambios son animados
    @IBInspectable public var animates: Bool = false // FIXME: Por hacer la animación de la CALayer
    
    /// Si la vista es circular
    @IBInspectable public var isCircular: Bool = true {
        didSet {
            if isCircular {
                self.layer.cornerRadius = self.bounds.height / 2
                self.clipsToBounds = true
                
                self.interiorView.layer.cornerRadius = self.interiorView.frame.height / 2
                self.interiorView.clipsToBounds = true
            } else {
                self.layer.cornerRadius = 0
                self.clipsToBounds = false
                
                self.interiorView.layer.cornerRadius = 0
                self.interiorView.clipsToBounds = false
            }
        }
    }
    
    /// Anchura del borde
    @IBInspectable public var borderWidth: CGFloat = 2 {
        didSet {
            self.layer.borderWidth = borderWidth
            self.updateInteriorView()
        }
    }
    
    /// Color del borde
    @IBInspectable public var borderColor: UIColor = .black {
        didSet {
            self.layer.borderColor = borderColor.cgColor
            setNeedsDisplay()
        }
    }
    
    /// Margen entre el borde y el relleno
    @IBInspectable public var margin: CGFloat = 5 {
        didSet {
            self.updateInteriorView()
        }
    }
    
    /// Color de relleno
    @IBInspectable public var fillColor: UIColor = .red {
        didSet {
            self.interiorView?.backgroundColor = fillColor
            setNeedsLayout()
        }
    }
    
    /// Porcentaje de relleno: [0..100]
    @IBInspectable public var fillPercentage: Int = 50 {
        didSet {
            self.updateInteriorView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    // MARK:- Private
    
    private func initSubviews() {
        
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.borderColor = self.borderColor.cgColor
        self.layer.borderWidth = self.borderWidth
        
        if self.isCircular {
            self.layer.cornerRadius = self.frame.height / 2
        }
        
        // Vista interior
        
        self.interiorView = UIView(frame: self.rectForInteriorView())
        self.interiorView.backgroundColor = fillColor
        
        if self.isCircular {
            self.interiorView.layer.cornerRadius = self.interiorView.frame.height / 2
            self.interiorView.clipsToBounds = true
        }
        
        self.interiorView.center = self.convert(self.center, from: self.interiorView)
        self.interiorView.layer.mask = self.maskForInteriorView()
        
        self.addSubview(self.interiorView)
    }
    
    private func updateInteriorView(){
        let oldCenter = self.interiorView.center
        self.interiorView.frame = rectForInteriorView()
        self.interiorView.center = oldCenter
        self.interiorView.layer.mask = maskForInteriorView()
        self.setNeedsLayout()
    }
    
    private func rectForInteriorView() -> CGRect {
        return CGRect(x: 0, y: 0, width: self.interiorViewHeight, height: self.interiorViewHeight)
    }
    
    private func maskForInteriorView() -> CALayer {
        
        guard let _ = self.interiorView else { return CALayer() }
        
        let maskHeight = self.interiorView.bounds.height * CGFloat(CGFloat(self.fillPercentage)/100.0)
        let maskOriginY = self.interiorView.bounds.height - maskHeight
        
        let maskRect = CGRect(origin: CGPoint(x: 0, y: maskOriginY), size: CGSize(width: self.interiorView.bounds.width, height: maskHeight))
        
        let myPath = CGMutablePath()
        myPath.addPath(CGPath(rect: maskRect, transform: nil))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = myPath
        maskLayer.fillRule = kCAFillRuleEvenOdd
        
        return maskLayer
    }
}
