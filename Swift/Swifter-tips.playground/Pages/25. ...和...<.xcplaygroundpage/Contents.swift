//: [Previous](@previous)

import Foundation

// 0...3 就表示从 0 开始到 3 为⽌并包含 3 这个数字的范 围，我们将其称为全闭合的范围操作；
// 0..<3  [0,3)

// ... 和..< 是支持泛型的，即实现 Comparable 协议的都可以
let test = "Hello"
let interval = "a"..."z"
for c in test {
    if !interval.contains(String(c)) {
        print("\(c) 不是小写字符")
    }
}

//let asciiChar = '\0'...'~'
//: [Next](@next)
