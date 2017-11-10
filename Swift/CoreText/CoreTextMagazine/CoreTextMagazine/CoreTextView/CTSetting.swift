//
//  CTSetting.swift
//  CoreTextMagazine
//
//  Created by X-Liang on 2017/11/10.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

import UIKit

class CTSetting {
    let margin: CGFloat = 20
    var columnPerPages: CGFloat!
    var pageRact: CGRect!
    var columnRact: CGRect!
    
    init() {
        columnPerPages = UIDevice.current.userInterfaceIdiom == .phone ? 1:2
        pageRact = UIScreen.main.bounds.insetBy(dx: margin, dy: margin)
        columnRact = CGRect(x: 0, y: 0, width: pageRact.width / columnPerPages, height: pageRact.height).insetBy(dx: margin, dy: margin)
    }
}
