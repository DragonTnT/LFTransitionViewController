//
//  UpdateView.swift
//  TransitionDemo
//
//  Created by Allen long on 2018/9/17.
//  Copyright © 2018年 Allen long. All rights reserved.
//

import UIKit

class UpdateView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.white.withAlphaComponent(0)
    }
    
    static let name = "UpdateView"
    
    var closeClosure: (()->())?

    @IBAction func closeAction(_ sender: UIButton) {
        closeClosure?()
    }

}
