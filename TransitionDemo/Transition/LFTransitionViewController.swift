//
//  UpdateVerisionViewController.swift
//  TransitionDemo
//
//  Created by Allen long on 2018/9/17.
//  Copyright © 2018年 Allen long. All rights reserved.
//

import UIKit


class LFTransitionViewController: UIViewController {
    
    var transitionStyle: LFTransitionStyle = .scaleChange
    var backViewType: LFBackGroundViewType = .dimming
    var transitionDuration: TimeInterval = 0.3

    init() {
        super.init(nibName: nil, bundle: nil)
        setupTransition()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTransition()
    }

    private func setupTransition() {
        self.transitioningDelegate = self
        self.modalPresentationStyle = .custom
    }
    
}

extension LFTransitionViewController: UIViewControllerTransitioningDelegate {
    //返回弹窗控制器容器，阴影效果
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        if presented == self {
            return LFPresentationVC(presentedViewController: presented, presentingViewController: presenting, backViewType: backViewType)
        }
        return nil
    }
    //弹出动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if presented == self {
            return LFViewControllerTransition(transitionStyle: transitionStyle, transitionType: .present, transitionDuration: transitionDuration)
        }
        return nil
    }
    //收起动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if dismissed == self {
            var dismissDistance: CGFloat? = nil
            
            if let firstSubView = self.view.subviews.first {
                switch transitionStyle {
                case .topToBottom:
                    dismissDistance = firstSubView.frame.origin.y + firstSubView.frame.size.height
                case .bottomToTop:
                    dismissDistance = UIScreen.main.bounds.size.height - firstSubView.frame.origin.y
                case .leftToRight:
                    dismissDistance = firstSubView.frame.origin.x + firstSubView.frame.size.width
                case .rightToLeft:
                    dismissDistance = UIScreen.main.bounds.size.width - firstSubView.frame.origin.x
                default:
                    break
                }
            }
            
            return LFViewControllerTransition(transitionStyle: transitionStyle, transitionType: .dismiss, transitionDuration: transitionDuration, dismissDistance: dismissDistance)
        }
        return nil
    }
}
