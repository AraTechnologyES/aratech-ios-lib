//
//  ExpandAnimationManager.swift
//  ATLibrary

import Foundation
import UIKit

open class ExpandAnimationManager: NSObject, UIViewControllerAnimatedTransitioning  {


	let duration = 1.0
	open var presenting = true
	open var originFrame = CGRect.zero
	
	
	public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return duration
	}
	
	
	public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		
		let containerView = transitionContext.containerView
		
		let toView = transitionContext.view(forKey: .to)!
		
		let herbView = presenting ? toView : transitionContext.view(forKey: .from)!
		
		let initialFrame = presenting ? originFrame : herbView.frame
		let finalFrame = presenting ? herbView.frame : originFrame
		
		let xScaleFactor = presenting ?
			initialFrame.width / finalFrame.width :
			finalFrame.width / initialFrame.width
		
		let yScaleFactor = presenting ?
			initialFrame.height / finalFrame.height :
			finalFrame.height / initialFrame.height
		
		let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
		
		if presenting {
			herbView.transform = scaleTransform
			herbView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
			herbView.clipsToBounds = true
		}
		
		containerView.addSubview(toView)
		containerView.bringSubview(toFront: herbView)
		
		UIView.animate(withDuration: duration, delay: 0.0,
		               usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, animations: { 
						herbView.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
						herbView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
		}) { _ in
			transitionContext.completeTransition(true)
		}
	}
	
}
