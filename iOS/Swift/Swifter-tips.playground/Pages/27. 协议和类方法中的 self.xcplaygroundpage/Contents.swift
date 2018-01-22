//: [Previous](@previous)

import Foundation
// 这么定义是因为协议其实本身是没有⾃⼰的上下⽂类型信息的，在声明协议的时候，我们并不知 道最后究竟会是什么样的类型来实现这个协议，Swift 中也不能在协议中定义泛型进⾏限制。
// 我们
// 希望在协议中使⽤的类型就是实现这个协议本身的类型的话，就需要使⽤ Self 进⾏指代。

// Self 不仅指代的是实现该协议的类型本身，也包括了这个类型的⼦类
protocol Copyable {
    func copy() -> Self
}

class MyClass: Copyable {
    var num = 1
    func copy() -> Self {
        // 使用 type(of:)来创建一个和当前上下文无关，又能指代当前类型的方式进行初始化
        // 又因为还有保证 MyClass 及其子类能够调用 init 成功，所以还需要添加 required init 初始化
        let result = type(of: self).init()
//        let result = type
        result.num = num
        return result
    }
    //
    required init() {
    }
}

class Class {
    static func myself() -> Self {
        return self.init()
    }
    
    required init() {
    }
}

//: [Next](@next)
