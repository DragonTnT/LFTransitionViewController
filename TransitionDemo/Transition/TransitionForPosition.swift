//
//  TransitionForPosition.swift
//  TransitionDemo
//
//  Created by Allen long on 2018/9/17.
//  Copyright © 2018年 Allen long. All rights reserved.
//

import UIKit

class TransitionForPosition: NSObject,UIViewControllerAnimatedTransitioning {
    var transitionStyle: LFTransitionStyle!   //动画效果
    var transitionDuration: TimeInterval   //动画时间
    var downToUp = Bool()         //present方向，默认为从下到上
    let isPresenting :Bool        //true为present,false为dismiss
    
    init(isPresenting: Bool, transitionDuration: TimeInterval = 0.5, transitionStyle: LFTransitionStyle) {
        self.isPresenting = isPresenting
        self.transitionDuration = transitionDuration
        self.transitionStyle = transitionStyle
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.transitionDuration
    }
    //弹出or收起动画
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting{
            animatePresentationWithTransitionContext(transitionContext)
        }
        else{
            animateDismissalWithTransitionContext(transitionContext)
        }
    }
    
    //弹出动画
    func animatePresentationWithTransitionContext(_ transitionContext: UIViewControllerContextTransitioning) {
        let presentedController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let presentedControllerView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        let containerView = transitionContext.containerView
        // Position the presented view off the top of the container view
        presentedControllerView?.frame = transitionContext.finalFrame(for: presentedController!)
        //将presentedControllerView放入准备弹出的位置
        switch transitionStyle {
        case .topToBottom:
            presentedControllerView?.center.y -= containerView.bounds.size.height
        case .bottomToTop:
            presentedControllerView?.center.y += containerView.bounds.size.height
        case .leftToRight:
            presentedControllerView?.center.x -= containerView.bounds.size.width
        case .rightToLeft:
            presentedControllerView?.center.x += containerView.bounds.size.width
        default:
            return
        }
        
        containerView.addSubview(presentedControllerView!)
        
        // 用UIView基础动画，完成presentedControllerView的frame变化
        UIView.animate(withDuration: transitionDuration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .allowUserInteraction, animations: {
            switch self.transitionStyle {
            case .topToBottom:
                presentedControllerView?.center.y += containerView.bounds.size.height
            case .bottomToTop:
                presentedControllerView?.center.y -= containerView.bounds.size.height
            case .leftToRight:
                presentedControllerView?.center.x += containerView.bounds.size.width
            case .rightToLeft:
                presentedControllerView?.center.x -= containerView.bounds.size.width
            default:
                return
            }
            
        }, completion: {(completed: Bool) -> Void in
            transitionContext.completeTransition(completed)
        })
    }
    //收起动画，过程与弹出动画相反
    func animateDismissalWithTransitionContext(_ transitionContext: UIViewControllerContextTransitioning) {
        let presentedControllerView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        let containerView = transitionContext.containerView
        
        UIView.animate(withDuration: transitionDuration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .allowUserInteraction, animations: {
            switch self.transitionStyle {
            case .topToBottom:
                presentedControllerView?.center.y -= containerView.bounds.size.height
            case .bottomToTop:
                presentedControllerView?.center.y += containerView.bounds.size.height
            case .leftToRight:
                presentedControllerView?.center.x -= containerView.bounds.size.width
            case .rightToLeft:
                presentedControllerView?.center.x += containerView.bounds.size.width                
            default:
                return
            }
        }, completion: {(completed: Bool) -> Void in
            transitionContext.completeTransition(completed)
        })
    }
}


