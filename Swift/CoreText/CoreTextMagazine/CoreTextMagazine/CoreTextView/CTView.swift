//
//  CTView.swift
//  CoreTextMagazine
//
//  Created by X-Liang on 2017/11/9.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

import UIKit
import CoreText

class CTView: UIScrollView {
    var attributeString: NSAttributedString!
    
    func importAttrString(_ attributeString: NSAttributedString) {
        self.attributeString = attributeString
    }
    
    func buildFrames(withAttributeString attributeString: NSAttributedString, images: [[String: Any]]) {
        isPagingEnabled = true
        let frameSetter = CTFramesetterCreateWithAttributedString(attributeString as CFAttributedString)
        
        var pageView = UIView()
        var textPos = 0
        var columnIndex: CGFloat = 0
        var pageIndex: CGFloat = 0
//        let settings = CTSettings()
//        //5
//        while textPos < attrString.length {
//        }
        
    }
    
    /*
    // 在视图创建时，draw 方法会自动指定，绘制整个背景图层
    override func draw(_ rect: CGRect) {
        // 获得用于绘制当前图形的上下文
        guard let context = UIGraphicsGetCurrentContext() else { return }
        // 创建一条用于限制绘制范围的路径，这里使用的是整个视图的 bounds
        let path = CGMutablePath()
        path.addRect(bounds)
        // 在Core Text，使用NSAttributedString而不是String或者NSString，保存文本和属性(attributes)。
        // 初始化一个"Hello World"的属性字符串。
        let attributeString = NSAttributedString(string: "Hello world")
        let framesetter = CTFramesetterCreateWithAttributedString(attributeString as CFAttributedString)
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attributeString.length), path, nil)
        // 翻转坐标系
        context.textMatrix = .identity
        context.translateBy(x: 0, y: bounds.size.height)
        context.scaleBy(x: 1, y: -1)
        
        CTFrameDraw(frame, context)
    }
     */
}
