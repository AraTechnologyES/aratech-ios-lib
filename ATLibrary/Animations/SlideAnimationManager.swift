//
//  SlideAnimationManager.swift
//  ATLibrary
//
//  Credits:    - https://www.thorntech.com/2016/03/ios-tutorial-make-interactive-slide-menu-swift/
//

import UIKit

/// Gestiona la animación de una presentación modal lateral tipo menu. Deben asignarse los controladores fuente y destino, así como el identificador de la `segue` al destino en el constructor.
open class SlideAnimationManager: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate  {
    
    public enum AnimationMode: String {
        case present
        case dismiss
        
        var direction: Direction {
            switch self {
            case .present:
                return .right
            case .dismiss:
                return .left
            }
        }
        
        var gesture: UIPanGestureRecognizer {
            switch self {
            case .present:
                // Gesto para presentar, desde el vertice izquierdo de la pantalla
                let gesture = UIScreenEdgePanGestureRecognizer()
                gesture.edges = UIRectEdge.left
                gesture.accessibilityLabel = self.rawValue
                return gesture
            case .dismiss:
                // Gesto para descartar la vista, arrastrar
                let gesture = UIPanGestureRecognizer()
                gesture.accessibilityLabel = self.rawValue
                return gesture
            }
        }
    }
	
	/// Indice de la subvista del snapshot que se oscurece al mostrar el menú lateral
	var snapshotSubviewIndex: Int {
		if #available(iOS 11.0, *) {
			return 0
		} else {
			return 1
		}
	}
    
    /// Tag para el snapshot de la vista origen
    fileprivate static let snapshotTag = 25
    
    /// Si la transición ha comenzado interactivamente
    private var isInProgress: Bool = false
    
    /// Si la transición debe completarse
    private var shouldCompleteTransition: Bool = false
    
    /// Si la transición puede iniciarse de manera interactiva
    private var isInteractive: Bool = false
    
    /// Modo de la animación, presentar o descartar
    public var mode: AnimationMode = .present
    
    /// Duración de la animación, 1 segundo por defecto
    public var animationDuration: TimeInterval = 1.0
    
    /// Umbral de completado de la transición, `0,5` por defecto
    public var completeTransitionTreshold: CGFloat = 0.5
    
    /// Anchura de la vista presentada, en porcentaje, `0.8` por defecto
    public var width: CGFloat = 0.8
    
    /// Opacidad de la vista a insertar encima de la vista origen, `0.5` por defecto
    public var sourceViewDarkenOpacity: CGFloat = 0.5
    
    /// Color de la vista a insertar encima de la vista origen, `negro` por defecto
    public var sourceViewDarkenColor: UIColor = .black
    
    /// Controlador origen
    public var source: UIViewController! {
        didSet {
            if self.isInteractive {
                let gesture = AnimationMode.present.gesture
                gesture.addTarget(self, action: #selector(handleGesture(gestureRecognizer:)))
                self.source.view.addGestureRecognizer(gesture)
            }
        }
    }
    
    /// Controlador destino
    public var destination: UIViewController! {
        didSet {
            if self.isInteractive {
                let gesture = AnimationMode.dismiss.gesture
                gesture.addTarget(self, action: #selector(handleGesture(gestureRecognizer:)))
                self.destination.view.addGestureRecognizer(gesture)
            }
        }
    }
    
    private var presentSegueIdentifier: String = ""
    
    @objc private func backgroundViewTapGestureSelector() {
        self.destination.dismiss(animated: true, completion: nil)
    }
    
    ///
    /// - Parameters:
    ///   - forSegue: Identificador de la segue al controlador presentado
    ///   - interactive: Si se puede realizar de manera interactiva, ej: deslizando, `false` por defecto
    public init(forSegue segueIdentifier: String, interactive: Bool = false) {
        super.init()
        self.presentSegueIdentifier = segueIdentifier
        self.isInteractive = interactive
    }
    
    // MARK:- UIViewControllerAnimatedTransitioning
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.animationDuration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to) else {
                return
        }
        
        let containerView = transitionContext.containerView
        
        self.prepare(for: self.mode, inContainer: containerView, from: fromViewController, to: toViewController)
        
        let snapshot = containerView.viewWithTag(SlideAnimationManager.snapshotTag)
        
        // Animación
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            
            switch self.mode {
                
            case .present:
                // Se traslada el centro de la vista destino una cantidad proporcional a la anchura de la pantalla, hacia la derecha
                toViewController.view.center.x += UIScreen.main.bounds.width * self.width
                
                // Se oscurece la vista añadida encima del snapshot para oscurecerlo
                snapshot?.subviews[self.snapshotSubviewIndex].alpha = self.sourceViewDarkenOpacity
                
            case .dismiss:
                if !transitionContext.transitionWasCancelled {
                    // Se mueve el centro de la vista origen, hacia la izquierda, una cantidad equivalente a su anchura visible, de tal forma que quedará oculta en la parte izquierda de la pantalla
                    fromViewController.view.center.x -= fromViewController.view.bounds.width
                    
                    // Se transparenta la vista añadida encima del snapshot para aclararla
                    snapshot?.subviews[self.snapshotSubviewIndex].alpha = 0
                }
            }
            
        }, completion: { _ in
            let didTransitionComplete = !transitionContext.transitionWasCancelled
            
            switch self.mode {
                
            case .present:
                fromViewController.view.isHidden = false
            case .dismiss:
                // Se comprueba que la transición no ha sido cancelada
                if didTransitionComplete {
                    // Se inserta la vista destino encima de la vista origen
                    containerView.insertSubview(toViewController.view, aboveSubview: fromViewController.view)
                    // Se elimina el snapshot de la jerarquía
                    snapshot?.removeFromSuperview()
                }
            }
            
            // Se completa la transición
            transitionContext.completeTransition(didTransitionComplete)
        })
    }
    
    private func prepare(for mode: AnimationMode, inContainer containerView: UIView, from fromViewController: UIViewController, to toViewController: UIViewController) {
        switch self.mode {
        case .present:
            
            // Insertar vista destino encima de vista origen, para que de la sensación de que esta última la cubre
            containerView.insertSubview(toViewController.view, aboveSubview: fromViewController.view)
            
            // Mover vista destino a la izquierda, de tal forma que aparecerá cubriendo la pantalla hacia la derecha cubriendo la vista origen
            toViewController.view.center.x -= containerView.frame.width
            
            // Creación Snapshot
            let snapshot = fromViewController.view.snapshotView(afterScreenUpdates: true)!
            snapshot.accessibilityIdentifier = "source Snapshot"
            snapshot.tag = SlideAnimationManager.snapshotTag
            snapshot.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.backgroundViewTapGestureSelector)))
            // Vista para oscurecer el snapshot
            let darkenView = UIView(frame: CGRect(x: 0, y: 0, width: snapshot.frame.width, height: snapshot.frame.height))
            darkenView.backgroundColor = self.sourceViewDarkenColor
            darkenView.accessibilityIdentifier = "darkenView"
            darkenView.alpha = 0
            snapshot.addSubview(darkenView)
			snapshot.bringSubviewToFront(darkenView)
            containerView.insertSubview(snapshot, belowSubview: toViewController.view)
            fromViewController.view.isHidden = true
            
        case .dismiss:
            break
        }
    }
    
    // MARK:- UIPercentDrivenInteractiveTransition
    
    @objc private func handleGesture(gestureRecognizer: UIPanGestureRecognizer) {
        
        guard let gestureIdentifier = gestureRecognizer.accessibilityLabel,
            let mode = AnimationMode(rawValue: gestureIdentifier) else { return }
        
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
        
        let progress = calculateProgress(translationInView: translation, viewBounds: gestureRecognizer.view!.superview!.bounds, direction: mode.direction)
        
        switch gestureRecognizer.state {
            
        case .began:
            isInProgress = true
            
            switch mode {
            case .present:
                if self.source.shouldPerformSegue(withIdentifier: self.presentSegueIdentifier, sender: self) {
                    self.source.performSegue(withIdentifier: self.presentSegueIdentifier, sender: self)
                }
            case .dismiss:
                self.destination.dismiss(animated: true, completion: nil)
            }
            
        case .changed:
            shouldCompleteTransition = progress > self.completeTransitionTreshold
            update(progress)
        case .cancelled:
            isInProgress = false
            cancel()
        case .ended:
            isInProgress = false
            
            if !shouldCompleteTransition {
                cancel()
            } else {
                finish()
            }
        default:
            print("Unsupported")
        }
    }
    
    // MARK:- UIViewControllerTransitioningDelegate
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.mode = .present
        return self
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.mode = .dismiss
        return self
    }
    
    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.isInProgress ? self : nil
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.isInProgress ? self : nil
    }
    
    // MARK:- Helper
    
    enum Direction: String {
        case up
        case down
        case left
        case right
    }
    
    private func calculateProgress(translationInView:CGPoint, viewBounds:CGRect, direction:Direction) -> CGFloat {
        let pointOnAxis:CGFloat
        let axisLength:CGFloat
        switch direction {
        case .up, .down:
            pointOnAxis = translationInView.y
            axisLength = viewBounds.height
        case .left, .right:
            pointOnAxis = translationInView.x
            axisLength = viewBounds.width
        }
        let movementOnAxis = pointOnAxis / axisLength
        let positiveMovementOnAxis:Float
        let positiveMovementOnAxisPercent:Float
        switch direction {
        case .right, .down: // positive
            positiveMovementOnAxis = fmaxf(Float(movementOnAxis), 0.0)
            positiveMovementOnAxisPercent = fminf(positiveMovementOnAxis, 1.0)
            
            return CGFloat(positiveMovementOnAxisPercent)
        case .up, .left: // negative
            positiveMovementOnAxis = fminf(Float(movementOnAxis), 0.0)
            positiveMovementOnAxisPercent = fmaxf(positiveMovementOnAxis, -1.0)
            
            return CGFloat(-positiveMovementOnAxisPercent)
        }
    }
}
