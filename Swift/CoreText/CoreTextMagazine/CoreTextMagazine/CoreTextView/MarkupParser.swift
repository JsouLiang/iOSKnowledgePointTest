//
//  MarkupParser.swift
//  CoreTextMagazine
//
//  Created by X-Liang on 2017/11/10.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

import UIKit

class MarkupParser: NSObject {
    var color: UIColor = .black
    var fontName: String = "Arial"
    var attributeString: NSMutableAttributedString!
    var images: [[String: Any]] = []
    
    // MARK: -initial
    override init() {
        super.init()
    }
    
    func parseMarkup(_ markup: String) {
        attributeString = NSMutableAttributedString(string: "")
        do {
            let regex = try NSRegularExpression(pattern: "(.*?)(<[^>]+>|\\Z)",
                                                options: [.caseInsensitive,
                                                          .dotMatchesLineSeparators])
            let chunks = regex.matches(in: markup,
                                       options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                       range: NSRange(location: 0, length: markup.count))
            let defaultFont = UIFont.systemFont(ofSize: UIScreen.main.bounds.size.height / 40)
            for chunk in chunks {
                guard let markupRange = markup.range(from: chunk.range) else { continue }
                let parts = String(markup[markupRange]).components(separatedBy: "<")
                let font = UIFont(name: fontName, size: UIScreen.main.bounds.height / 40) ?? defaultFont
                let attributes = [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: font] as [NSAttributedStringKey: Any]
                let text = NSMutableAttributedString(string: parts[0], attributes: attributes)
                attributeString.append(text)
                
                if parts.count <= 1 {
                    continue
                }
                let tag = parts[1]
                if tag.hasPrefix("font") {
                    let colorRegex = try NSRegularExpression(pattern: "(?<=color=\")\\w+",
                                                             options: NSRegularExpression.Options(rawValue: 0))
                    colorRegex.enumerateMatches(in: tag, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, tag.count), using: { (match, _, _) in
                        if let match = match, let range = tag.range(from: match.range) {
                            let colorSel = NSSelectorFromString(String(tag[range]) + "Color")
                            color = UIColor.perform(colorSel).takeRetainedValue() as? UIColor ?? .black
                        }
                    })
                    
                    let faceRegex = try NSRegularExpression(pattern: "(?<=face=\")[^\"]+",
                                                           options: NSRegularExpression.Options(rawValue: 0))
                    faceRegex.enumerateMatches(in: tag,
                                               options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                               range: NSMakeRange(0, tag.count)) { (match, _, _) in
                                                
                                                if let match = match,
                                                    let range = tag.range(from: match.range) {
                                                    fontName = String(tag[range])
                                                }
                    }
                }
            }
        }catch _ {}
    }
}
