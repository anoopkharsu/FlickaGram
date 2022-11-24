//
//  MoveElementsTransition.swift
//  FlickaGram
//
//  Created by Anoop Kharsu on 24/11/22.
//

import UIKit

class MoveElementsTransition: NSObject, UIViewControllerAnimatedTransitioning {
    var duration: TimeInterval = 1
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewController(forKey: .from) as! TransitionInfo
        let toVC = transitionContext.viewController(forKey: .to) as! TransitionInfo
        
        let containerView = transitionContext.containerView
        
        containerView.addSubview(fromVC.view)
        containerView.addSubview(toVC.view)
        
       

        let image = UIImageView()
        image.image = toVC.cellView?.imageView.image
        if toVC.cellView == nil {
            image.image = fromVC.cellView?.imageView.image
            image.frame = fromVC.cellView?.imageView.superview!.convert(fromVC.cellView!.imageView.frame, to: nil) ?? .zero
            image.contentMode = .scaleAspectFit
            
            fromVC.cellView?.titleLabelView.alpha = 0
            fromVC.cellView?.imageView.alpha = 0
            toVC.cellView?.titleLabelView.alpha = 0
            toVC.cellView?.imageView.alpha = 0
            
            containerView.addSubview(image)

            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                let frame1 = CGRect(origin: .zero, size: toVC.view.frame.size)

                image.frame = frame1

            }) { (_) -> Void in
                image.removeFromSuperview()
                fromVC.cellView?.titleLabelView.alpha = 1
                fromVC.cellView?.imageView.alpha = 1
                toVC.cellView?.titleLabelView.alpha = 1
                toVC.cellView?.imageView.alpha = 1
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        } else {
            image.frame = fromVC.cellView?.imageView.superview!.convert(fromVC.cellView!.imageView.frame, to: nil) ?? .zero
      
            fromVC.cellView?.titleLabelView.alpha = 0
            fromVC.cellView?.imageView.alpha = 0
            toVC.cellView?.titleLabelView.alpha = 0
            toVC.cellView?.imageView.alpha = 0
            containerView.addSubview(image)

            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                let frame1 = toVC.cellView?.imageView.superview!.convert(toVC.cellView!.imageView.frame, to: nil) ?? .zero

                image.frame = frame1

            }) { (_) -> Void in
                image.removeFromSuperview()
                fromVC.cellView?.titleLabelView.alpha = 1
                fromVC.cellView?.imageView.alpha = 1
                toVC.cellView?.titleLabelView.alpha = 1
                toVC.cellView?.imageView.alpha = 1
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
}

protocol TransitionInfo {
    var view: UIView! { get } 
    var cellView: ImageViewCell? {get}
}
