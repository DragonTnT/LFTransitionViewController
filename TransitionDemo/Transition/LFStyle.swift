//
//  LFStyle.swift
//  TransitionDemo
//
//  Created by Allen long on 2019/7/10.
//  Copyright © 2019 Allen long. All rights reserved.
//

import Foundation


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
enum LFAnimationType {
    case present        //弹出
    case dismiss        //消失
}

//背景样式
enum LFBackGroundViewType {
    case dimming        //阴影
    case glass          //玻璃
}
