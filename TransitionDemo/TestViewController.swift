//
//  TestViewController.swift
//  TransitionDemo
//
//  Created by Allen long on 2018/9/17.
//  Copyright © 2018年 Allen long. All rights reserved.
//

fileprivate let kScreenH: CGFloat = UIScreen.main.bounds.height
fileprivate let kScrennW: CGFloat = UIScreen.main.bounds.width
fileprivate let kUpdateViewH: CGFloat = 397   //弹窗高度
fileprivate let kUpdateViewW: CGFloat = 330   //弹窗宽度

import UIKit

class TestViewController: LFTransitionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(updateView)
        updateView.closeClosure = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    lazy var updateView: UpdateView = {
        let view = Bundle.main.loadNibNamed(UpdateView.name, owner: nil, options: nil)?.first as! UpdateView
        view.frame = CGRect(x: (kScrennW - kUpdateViewW)/2, y: (kScreenH - kUpdateViewH)/2, width: kUpdateViewW, height: kUpdateViewH)
        return view
    }()    
}
