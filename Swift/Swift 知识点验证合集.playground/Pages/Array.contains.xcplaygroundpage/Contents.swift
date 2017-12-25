//: [Previous](@previous)

import Foundation

// Swift 中判断数组是否包含某个元素可以使用 contains
let array = [2, 5, 6, 7, 19, 40]

array.contains(10)                // false
array.contains(2)                 // true
// contains 这个方法要求数组中的元素类型实现了Equatable协议，否则无法使用

enum Animal {
    case dog
    case cat(Int)
}

let animals: [Animal] = [.dog, .dog]
//let hasCat = animals.contains(.cat(100))    // 编译器错误
let hasCat = animals.contains { animal in
    if case .cat = animal {
        return true
    } else {
        return false
    }
}


//: [Next](@next)
