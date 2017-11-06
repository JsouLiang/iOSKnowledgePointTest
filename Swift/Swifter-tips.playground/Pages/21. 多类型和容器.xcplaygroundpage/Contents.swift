//: [Previous](@previous)

import Foundation
// 如果我们要把不相关的类型放到同⼀个容器类型中的话，需要做⼀些转换的⼯作
// Any 类型可以隐式转换
let mixed = [1, "two", 3] as [Any]
let mix: [Any] = [1, "two", 3]
// 转化为 NSObject
let objectArray = [1 as NSObject, "two" as NSObject, 3 as NSObject]

class Person {}
let person = Person()
class Human {}
let human = Human()

let obj = [person, human, "Three"] as [Any]

enum IntOrString {
    case intValue(Int)
    case stringValue(String)
}
let values = [IntOrString.intValue(1),
            IntOrString.stringValue("two"),
            IntOrString.intValue(3)]

for value in values {
    switch value {
    case let .intValue(i):
        print(i * 2)
    case let .stringValue(i):
        print(i.description)
    }
}
//: [Next](@next)
