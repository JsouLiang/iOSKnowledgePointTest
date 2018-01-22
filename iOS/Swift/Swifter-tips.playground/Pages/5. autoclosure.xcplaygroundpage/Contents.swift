//: [Previous](@previous)

import Foundation

// @autoclosure 就是将一句表达式封装成为闭包
// @autoclosure 仅支持 () -> T 这种类型的闭包，闭包不能接收参数
func logIfTure(_ predicate: () -> Bool) {
    if predicate() {
        print("True")
    }
}

logIfTure {
    return 2 > 1
}
// Swift 中我们可以对只有一个返回语句的 closure 进行简化
logIfTure{ 2 > 1}

func logInifTrue(_ predicate: @autoclosure () -> Bool) {
    if predicate() {
        print("True")
    }
}
// Swift 会自动将 2 > 1 转换为 () -> Bool
logInifTrue(2 > 1)

/*
 ??
 */
let defaultValue = 1
var level: Int?
var value = level ?? defaultValue   // ?? 能够在左值有值的情况下返回左值，没有值的情况下返回右值

/*
 ??
 的实现体如下：
 func ??<T>(optional: T?, defaultValue: @autoclosure () -> T?) -> T?
 
 func ??<T>(optional: T?, defaultValue: @autoclosure () -> T) -> T
 第二个参数为什么是闭包？？
 如果我们直接使⽤ T ，那么就意味着在 ?? 操作符真正取值之前，我们就必须准备好⼀ 个默认值传⼊到这个⽅法中，
 ⼀般来说这不会有很⼤问题，但是如果这个默认值是通过⼀系列复 杂计算得到的话，可能会成为浪费
 -- 因为其实如果 optional 不是 nil 的话，我们实际上是完全 没有⽤到这个默认值，⽽会直接返回 optional 解包后的值的。
 这样的开销是完全可以避免的，⽅ 法就是将默认值的计算推迟到 optional 判定为 nil 之后。
 */
func ??<T> (optional: T?, defaultValue: @autoclosure () -> T ) -> T {
    switch optional {
    case .some(let value):
        return value
    case .none
        return defaultValue()
    }
}

//: [Next](@next)
