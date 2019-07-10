//
//  LFViewControllerTransition.swift
//  TransitionDemo
//
//  Created by Allen long on 2019/7/10.
//  Copyright © 2019 Allen long. All rights reserved.
//

import UIKit

//MARK:-property and lifecycle
class LFViewControllerTransition: NSObject {
    var transitionStyle: LFTransitionStyle              //style about how to present the viewcontroller
    var transitionType: LFAnimationType     //present or dismiss
    var transitionDuration: TimeInterval                //duration that transition will take
    var dismissDistance: CGFloat?                       //dismissDistance make the animation smoother
    
    init(transitionStyle: LFTransitionStyle, transitionType: LFAnimationType, transitionDuration: TimeInterval, dismissDistance: CGFloat? = nil) {
        self.transitionStyle = transitionStyle
        self.transitionType = transitionType
        self.transitionDuration = transitionDuration
        self.dismissDistance = dismissDistance
        super.init()
    }
}

//MARK:- UIViewControllerAnimatedTransitioning
extension LFViewControllerTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if transitionType == .present {
            animatePresentWithContext(transitionContext)
        } else {
            animateDismissWithContext(transitionContext)
        }
    }
}

//MARK:- Helper
extension LFViewControllerTransition {
    
    private func animatePresentWithContext(_ transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
        guard let toVCView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        let containerView = transitionContext.containerView
        
        toVCView.frame = transitionContext.finalFrame(for: toVC)
        
        //将presentedControllerView放入准备弹出的位置
        switch transitionStyle {
        case .topToBottom:
            toVCView.center.y -= containerView.bounds.size.height
        case .bottomToTop:
            toVCView.center.y += containerView.bounds.size.height
        case .leftToRight:
            toVCView.center.x -= containerView.bounds.size.width
        case .rightToLeft:
            toVCView.center.x += containerView.bounds.size.width
        case .alphaChange:
            toVCView.alpha = 0
        case .scaleChange:
            toVCView.transform = CGAffineTransform(scaleX: 0, y: 0)
        }
        
        containerView.addSubview(toVCView)
        
        // 用UIView基础动画，完成presentedControllerView的frame变化
        UIView.animate(withDuration: transitionDuration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .allowUserInteraction, animations: {
            
            switch self.transitionStyle {
            case .topToBottom:
                toVCView.center.y += containerView.bounds.size.height
            case .bottomToTop:
                toVCView.center.y -= containerView.bounds.size.height
            case .leftToRight:
                toVCView.center.x += containerView.bounds.size.width
            case .rightToLeft:
                toVCView.center.x -= containerView.bounds.size.width
            case .alphaChange:
                toVCView.alpha = 1
            case .scaleChange:
                toVCView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }
            
        }, completion: {(completed: Bool) -> Void in
            
            //比例变化再这里有一个弹性操作
            if self.transitionStyle == .scaleChange {
                UIView.animate(withDuration: 0.1, animations: {
                    toVCView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }, completion: { (completed) in
                    transitionContext.completeTransition(completed)
                })
                return
            }
            
            transitionContext.completeTransition(completed)
        })
    }
    
    private func animateDismissWithContext(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVCView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
        let containerView = transitionContext.containerView
        
        UIView.animate(withDuration: transitionDuration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .allowUserInteraction, animations: {
            
            switch self.transitionStyle {
            case .topToBottom:
                fromVCView.center.y -= self.dismissDistance ?? containerView.bounds.size.height
            case .bottomToTop:
                fromVCView.center.y += self.dismissDistance ?? containerView.bounds.size.height
            case .leftToRight:
                fromVCView.center.x -= self.dismissDistance ?? containerView.bounds.size.width
            case .rightToLeft:
                fromVCView.center.x += self.dismissDistance ?? containerView.bounds.size.width
            case .alphaChange:
                fromVCView.alpha = 0
            case .scaleChange:
                fromVCView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                fromVCView.alpha = 0
            }
        }, completion: {(completed: Bool) -> Void in
            
            if self.transitionStyle == .scaleChange {
                fromVCView.transform = CGAffineTransform.identity
                fromVCView.alpha = 1.0
            }
            
            transitionContext.completeTransition(completed)
        })
    }
}
