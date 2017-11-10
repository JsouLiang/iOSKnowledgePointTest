//
//  ViewController.swift
//  CoreTextMagazine
//
//  Created by X-Liang on 2017/11/9.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let file = Bundle.main.path(forResource: "zombies", ofType: "txt") else {
            return
        }
        do {
            let text = try String(contentsOfFile: file, encoding: .utf8)
            let parser = MarkupParser()
            parser.parseMarkup(text)
            (view as? CTView)?.importAttrString(parser.attributeString)
        } catch _ {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

