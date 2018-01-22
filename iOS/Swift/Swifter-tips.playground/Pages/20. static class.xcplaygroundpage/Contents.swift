//: [Previous](@previous)

import Foundation

// 在非 class 的类型上下文中，我们统一使用 static 来描述类型作用域
struct Point {
    let x: Double
    let y: Double
    // 存储属性
    static let zero = Point(x: 0, y: 0)
    // 计算属性
    static var ones: [Point] {
        return [
            Point(x: 1, y: 1),
            Point(x: -1, y: 1),
            Point(x: -1, y: -1),
            Point(x: 1, y: -1),
        ]
    }
    // 类型方法
    static func add(p1: Point, p2: Point) -> Point {
        return Point(x: p1.x + p2.x, y: p1.y + p2.y)
    }
}

// class 关键字使用在 class 类型上下文中，可以用来修饰方法，及类的计算属性，但是不能修饰 class 的存储属性
class Class {
//    class var bar: Int?     Error
//    Swift 1.2 后我们可以在 class 中使用 static 修饰一个静态存储属性
    static var bar: Int?
}

// 在 protocol 里定义一个类型域上的方法或者计算属性应该使用哪个关键字
// static
protocol Protocol {
    static func foo()
}

struct Struct: Protocol {
    static func foo() {
        
    }
}

enum Enum: Protocol {
    static func foo() {
        
    }
}

class MyClass: Protocol {
    static func foo() {

    }
    // 也可以用 class
//    class func foo() {
//    }
}


//: [Next](@next)
