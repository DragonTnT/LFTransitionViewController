//
//  LFPresentationVC.swift
//  TransitionDemo
//
//  Created by Allen long on 2018/9/17.
//  Copyright © 2018年 Allen long. All rights reserved.
//


import UIKit

class LFPresentationVC: UIPresentationController {
    //默认背景为阴影效果
    var backViewType : LFBackGroundViewType!
    
    init(presentedViewController: UIViewController, presentingViewController: UIViewController?, backViewType: LFBackGroundViewType = .dimming) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        self.backViewType = backViewType
    }
    //阴影
    lazy var dimmingView :UIView = {
        let view = UIView(frame: self.containerView!.bounds)
        view.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        view.alpha = 0
        return view
    }()
    //毛玻璃
    lazy var glassView : UIVisualEffectView = {
        var blurEffect : UIBlurEffect!
        blurEffect = UIBlurEffect(style: .light)
        
        let effectview = UIVisualEffectView(effect: blurEffect)
        effectview.frame = UIScreen.main.bounds
        effectview.alpha = 0
        return effectview
    }()
    //以下为UIPresentationController的周期
    override func presentationTransitionWillBegin() {
        guard
            let containerView = containerView,
            let presentedView = presentedView
            else {
                return
        }
        if self.backViewType == .dimming {
            dimmingView.frame = containerView.bounds
            containerView.addSubview(dimmingView)
            containerView.addSubview(presentedView)
        }else{
            glassView.frame = containerView.bounds
            containerView.addSubview(glassView)
            containerView.addSubview(presentedView)
        }        
        
        if let transitionCoordinator = self.presentingViewController.transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: { (context:
                UIViewControllerTransitionCoordinatorContext!) -> Void in
                if self.backViewType == .dimming {
                    self.dimmingView.alpha = 1.0
                }else{
                    self.glassView.alpha = 1.0
                }
            }, completion: nil)
        }
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed{
            if self.backViewType == .dimming {
                self.glassView.alpha = 1.0
            }else{
                self.glassView.alpha = 1.0
            }
        }
    }
    
    override func dismissalTransitionWillBegin() {
        if let transitionCoordinator = self.presentingViewController.transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: {(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
                if self.backViewType == .dimming {
                    self.dimmingView.alpha  = 0.0
                }else{
                    self.glassView.alpha = 0.0
                }
            }, completion:nil)
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            if self.backViewType == .dimming {
                self.dimmingView.removeFromSuperview()
            }else{
                self.glassView.removeFromSuperview()
            }
        }
    }
    
    override var frameOfPresentedViewInContainerView : CGRect {
        guard
            let containerView = containerView
            else {
                return CGRect()
        }
        var frame = containerView.bounds;
        frame = frame.insetBy(dx: 0.0, dy: 0.0)
        return frame
    }
}
