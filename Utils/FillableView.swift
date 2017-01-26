//
//  FillableCircleView.swift
//  Utils
//
//  Animation credit to: http://stackoverflow.com/a/36461202/5014794

import UIKit

// FIXME:- En Interfaz Builder la vista interior no está bien encajada

/// Vista rellenable
@IBDesignable open class FillableView: UIView {
    
    private var interiorView: UIView!
    
    private var interiorViewHeight: CGFloat {
        return self.frame.height - self.borderWidth*2 - self.margin*2
    }
    
    private var interiorViewWidth: CGFloat {
        return self.frame.width - self.borderWidth*2 - self.margin*2
    }
    
    // MARK:- API
    
    /// Si los cambios son animados
    @IBInspectable public var animates: Bool = false
    
    /// Tiempo de duración de la animación
    @IBInspectable public var animationTime: CFTimeInterval = 1.0
    
    /// Si la vista es circular
    @IBInspectable public var isCircular: Bool = true {
        didSet {
            if isCircular {
                self.layer.cornerRadius = self.bounds.height / 2
                self.clipsToBounds = true
                
                self.interiorView.layer.cornerRadius = self.interiorViewHeight / 2
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
            self.clipsToBounds = true
        }
        
        // Vista interior
        
        self.interiorView = UIView(frame: self.rectForInteriorView())
        self.interiorView.backgroundColor = fillColor
        
        if self.isCircular {
            self.interiorView.layer.cornerRadius = self.interiorViewHeight / 2
            self.interiorView.clipsToBounds = true
        }
        
        self.interiorView.center = self.convert(self.center, from: self.interiorView)
        self.interiorView.layer.mask = self.maskForInteriorView()
        
        self.addSubview(self.interiorView)
    }
    
    private func updateInteriorView(){
        
        // Nuevo frame
        self.interiorView.frame = self.rectForInteriorView()
        // Si es circular hay que actualizar el cornerRadius por si ha cambiado el tamaño del frame
        if self.isCircular { self.interiorView.layer.cornerRadius = self.interiorViewHeight/2 }
        
        // Nueva máscara
        self.interiorView.layer.mask = self.maskForInteriorView()
        
        self.setNeedsLayout()
        
    }
    
    private func rectForInteriorView() -> CGRect {
        
        // Calcular origen de la vista interior: origen vista exterior + anchura borde + margen entre las vistas
        let origin = CGPoint(x: self.borderWidth+self.margin, y: self.borderWidth+self.margin)
        
        let size = CGSize(width: self.interiorViewWidth, height: self.interiorViewHeight)
        
        return CGRect(origin: origin, size: size)
    }
    
    private func maskForInteriorView() -> CALayer {
        
        guard let _ = self.interiorView else { return CALayer() }
        
        let maskHeight = self.interiorView.bounds.height * CGFloat(CGFloat(self.fillPercentage)/100.0)
        let maskOriginY = self.interiorView.bounds.height - maskHeight
        
        let maskRect = CGRect(origin: CGPoint(x: 0, y: maskOriginY), size: CGSize(width: self.interiorView.bounds.width, height: maskHeight))
        
        let myPath = CGMutablePath()
        myPath.addPath(CGPath(rect: maskRect, transform: nil))
        
        let maskLayer = CAShapeLayer()
        
        if self.animates, let mask = self.interiorView.layer.mask as? CAShapeLayer {
            // create new animation
            let anim = CABasicAnimation(keyPath: "path")
            
            // from value is the current mask path
            anim.fromValue = mask.path
            
            // to value is the new path
            anim.toValue = myPath
            
            // duration of your animation
            anim.duration = self.animationTime
            
            // custom timing function to make it look smooth
            anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            
            // add animation
            maskLayer.add(anim, forKey: nil)
        }
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        maskLayer.path = myPath
        CATransaction.commit()
        
        maskLayer.fillRule = kCAFillRuleEvenOdd
        
        return maskLayer
    }
}
