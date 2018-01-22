//: [Previous](@previous)

import Foundation

struct Vector2D {
    var x = 0.0
    var y = 0.0
}

let v1 = Vector2D(x: 2.0, y: 3.0)
let v2 = Vector2D(x: 1.0, y: 4.0)

func +(left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}
let value = v1 + v2

// 自定义运算符
precedencegroup DotProductPrecedence {
    associativity: none         // 结合律
    higherThan: MultiplicationPrecedence    // 高于某个优先级
}
// infix 中位操作符，即前后都是输⼊；其他的修饰⼦还包括 postfix
infix operator +*: DotProductPrecedence
// Swift 的操作符是不能定义在局部域中的，因为⾄少会希望在能在全局范 围使⽤你的操作符，否则操作符也就失去意义了。
func +*(left: Vector2D, right: Vector2D) -> Double {
    return left.x * right.x + left.y * right.y
}
let result = v1 +* v2
//: [Next](@next)
