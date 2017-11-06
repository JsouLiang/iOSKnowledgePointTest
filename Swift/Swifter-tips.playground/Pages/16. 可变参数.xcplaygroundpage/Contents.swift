//: [Previous](@previous)

import Foundation
// 可变参数函数指的是可以接受任意多个参数的函数

// 写⼀个可变参数的函数只需要在声明参数时 在类型后⾯加上 ... 就可以了
func sum(input: Int...) -> Int {
    // 输入的 input 在函数内当做数组来使用
    return input.reduce(0, +)
}

//: 可变参数限制
//: 1. 同一个方法中只能有一个参数是可变的
//: 2. 可变参数必须是同一种类型

//: [Next](@next)
