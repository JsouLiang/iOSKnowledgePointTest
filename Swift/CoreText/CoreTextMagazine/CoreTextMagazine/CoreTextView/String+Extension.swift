//
//  String+Extension.swift
//  CoreTextMagazine
//
//  Created by X-Liang on 2017/11/10.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

import Foundation

extension String {
    func range(from range: NSRange) -> Range<String.Index>? {
        guard let from16 = utf16.index(utf16.startIndex, offsetBy: range.location, limitedBy: utf16.endIndex),
              let to16 = utf16.index(utf16.startIndex, offsetBy: range.length, limitedBy: utf16.endIndex),
              let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self) else {
                return nil
        }
        return from..<to
    }
}
