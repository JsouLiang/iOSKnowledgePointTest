//: [Previous](@previous)

import Foundation

// 在 OC 中获取任意实例的类型我们可以通过 class
// 我们希望在协议中使⽤的类型就是实现这个协议本身的类型的话，就需要使⽤ Self 进⾏指代。

let date = NSDate()
let dateType = type(of: date)
print(dateType)

let string = "Hello"
let stringType = type(of: string)
print(stringType)
//: [Next](@next)
