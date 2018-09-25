//
//  UpdateVerisionViewController.swift
//  TransitionDemo
//
//  Created by Allen long on 2018/9/17.
//  Copyright © 2018年 Allen long. All rights reserved.
//

import UIKit
//动画的效果类型
enum LFTransitionStyle: Int {
    case scaleChange    //比例变化
    case alphaChange    //透明度变化
    case topToBottom    //从上至下
    case bottomToTop    //从下至上
    case leftToRight    //从左至右
    case rightToLeft    //从右至左
}

//弹出or收起
enum ViewControllerAnimationType {
    case present
    case dismiss
}

class LFTransitionViewController: UIViewController {
    
    var transitionStyle: LFTransitionStyle = .scaleChange
    
    init(transitionStyle: LFTransitionStyle) {
        super.init(nibName: nil, bundle: nil)
        self.transitioningDelegate = self
        self.modalPresentationStyle = .custom
        self.transitionStyle = transitionStyle
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError()
    }
}

extension LFTransitionViewController: UIViewControllerTransitioningDelegate {
    //返回弹窗控制器容器，阴影效果
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        if presented == self {
            return PresentationVC(presentedViewController: presented, presentingViewController: presenting)
        }
        return nil
    }
    //弹出动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch transitionStyle {
        case .scaleChange:
            return TransitionForScaleOrAlpha(type: .present, isScaleChange: true)
        case.alphaChange:
            return TransitionForScaleOrAlpha(type: .present, isScaleChange: false)
        case .topToBottom,.bottomToTop,.leftToRight,.rightToLeft:
            return TransitionForPosition(isPresenting: true, transitionStyle: transitionStyle)
        default:
            return nil
        }
    }
    //收起动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch transitionStyle {
        case .scaleChange:
            return TransitionForScaleOrAlpha(type: .dismiss, isScaleChange: true)
        case .alphaChange:
            return TransitionForScaleOrAlpha(type: .dismiss, isScaleChange: false)
        case .topToBottom,.bottomToTop:
            return TransitionForPosition(isPresenting: false, transitionStyle: transitionStyle)
        case .leftToRight,.rightToLeft:
            return TransitionForPosition(isPresenting: false, transitionStyle: transitionStyle)
        default:
            return nil
        }
    }
}
