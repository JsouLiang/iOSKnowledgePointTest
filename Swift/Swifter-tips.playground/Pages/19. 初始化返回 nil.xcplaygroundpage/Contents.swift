//: [Previous](@previous)

import Foundation
// 我们还会在初始化失 败 (⽐如输⼊不满⾜要求⽆法正确初始化) 的时候返回 nil 来通知调⽤者这次初始化没有正确完 成。
// 可以在 init 声明时在其后加上⼀个 ? 或者 ! 来表示初始化失败时可能返回 nil

extension Int {
    init?(fromString: String) {
        self = 0        // 可以对 self 进⾏赋值，也算是 init ⽅法⾥的特权之 ⼀。
        var digit = fromString.count - 1
        for c in fromString {
            var number = 0
            if let n = Int(String(c)) {
                number = n
            } else {
                switch c {
                case "⼀": number = 1
                case "⼆": number = 2
                case "三": number = 3
                case "四": number = 4
                case "五": number = 5
                case "六": number = 6
                case "七": number = 7
                case "⼋": number = 8
                case "九": number = 9
                case "零": number = 0
                default: return nil
                }
            }
            self = self + number * Int(pow(10, Double(digit)))
            digit = digit - 1
        }
    }
}

//: [Next](@next)
