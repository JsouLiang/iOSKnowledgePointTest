//: [Previous](@previous)

import Foundation

// Swift 中的 func 中的参数，默认都是 let 的
func incrementor(variable: Int) -> Int {
    return variable + 1
}
// 如果我们想要在方法中直接修改传入值，可以把参数声明为 inout
func incrementor(variable: inout Int) {
    variable += 1
}
// Int 其实是⼀个值类型，我们 并不能直接修改它的地址来让它指向新的值
// 对于值类型来说， inout 相当于在函数内部创建了⼀个新的值，
// 然后在函数返回时将这 个值赋给 & 修饰的变量，这与引⽤类型的⾏为是不同的。
var value = 7
incrementor(variable: &value)


func makeIncrementor(addedNum: Int) -> ((inout Int) -> ()) {
    return { (value: inout Int) -> () in
        value += addedNum
    }
}
let add3 = makeIncrementor(addedNum: 3)
var v = 4
add3(&v)

//: [Next](@next)
