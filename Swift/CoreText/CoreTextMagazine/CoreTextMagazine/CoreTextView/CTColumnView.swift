//
//  CTColumnView.swift
//  CoreTextMagazine
//
//  Created by X-Liang on 2017/11/10.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

import UIKit

class CTColumnView: UIView {
    var ctFrame: CTFrame!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required init(frame: CGRect, ctFrame: CTFrame) {
        super.init(frame: frame)
        self.ctFrame = ctFrame
        backgroundColor = .white
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.textMatrix = .identity
        context.translateBy(x: 0, y: bounds.size.height)
        context.scaleBy(x: 1, y: -1)
        
        CTFrameDraw(ctFrame, context)
    }
}
