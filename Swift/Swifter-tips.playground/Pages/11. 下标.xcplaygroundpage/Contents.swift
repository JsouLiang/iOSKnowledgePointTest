//: [Previous](@previous)

import Foundation
// 字典需要注意，我们通过下标访问得到的结果是⼀个 Optional 的值。
// Swift 是允许我们⾃定义下标的

// 拓展 Array 使其支持传入一组 index ，返回这组 index 作为下标对应的值
extension Array {
    subscript(indexs: [Int]) -> [Element] {
        get {
            var result = Array()
            for index in indexs {
                assert(index < self.count, "Index out of range")
                result.append(self[index])
            }
            return result
        }
        set {
            for (index, value) in indexs.enumerated() {
                assert(value < self.count, "Index out of range")
                self[value] = newValue[index]
            }
        }
    }
}

//: [Next](@next)
