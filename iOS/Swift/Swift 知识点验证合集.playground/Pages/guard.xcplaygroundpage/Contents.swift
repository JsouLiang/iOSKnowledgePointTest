//: [Previous](@previous)

//: Guard 使用场景
import Foundation

//: 1. 在验证入口条件时
// 只有在满足某些先决条件的情况下，方法才能够被继续执行
var value: Int?
func testGuard() {
    guard let value = value else {
        return
    }
    //
    print(value)
}

// guard else 中使用 日志、崩溃和断言中


//: [Next](@next)
