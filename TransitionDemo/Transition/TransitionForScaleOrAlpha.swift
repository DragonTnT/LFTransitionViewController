//
//  TransitionForScaleOrAlpha.swift
//  TransitionDemo
//
//  Created by Allen long on 2018/9/17.
//  Copyright © 2018年 Allen long. All rights reserved.
//

import UIKit

class TransitionForScaleOrAlpha: NSObject {
    var isScaleChange: Bool!   //为true时，动画效果比例变化，为false时，效果为透明度变化
    var type: ViewControllerAnimationType!
    init(type: ViewControllerAnimationType, isScaleChange: Bool) {
        super.init()
        self.type = type
        self.isScaleChange = isScaleChange
    }
}

extension TransitionForScaleOrAlpha : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        if self.type == .present {
            return 0.3   //弹出时间
        }else{
            return 0.1   //收起时间
        }
        
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if self.type == .present {
            animatedPresentWithContext(transitionContext: transitionContext)
        }else{
            animatedDismissWithContext(transitionContext: transitionContext)
        }
    }
    //弹出动画
    func animatedPresentWithContext(transitionContext: UIViewControllerContextTransitioning) {
        let toVC = transitionContext.viewController(forKey: .to)!
        let containerView = transitionContext.containerView
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        
        if isScaleChange {   //比例变化
            toVC.view.transform = CGAffineTransform(scaleX: 0, y: 0)
            containerView.addSubview(toVC.view)
            UIView.animate(withDuration: 0.3, animations: {
                toVC.view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }) { (finished) in
                UIView.animate(withDuration: 0.1, animations: {
                    toVC.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }, completion: { (completed) in
                    transitionContext.completeTransition(completed)
                })
            }
        } else {
            toVC.view.alpha = 0   //透明度变化
            UIView.animate(withDuration: 0.3, animations: {
                toVC.view.alpha = 1
            }) { (finished) in
                transitionContext.completeTransition(finished)
            }
        }
        
    }
    //收起动画
    func animatedDismissWithContext(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)!
        UIView.animate(withDuration: 0.3, animations: {
            if self.isScaleChange {
                fromVC.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            } else {
                fromVC.view.alpha = 0
            }
        }) { (finished) in
            transitionContext.completeTransition(finished)
        }
    }
}


