//: [Previous](@previous)

import UIKit
// Swift 中的 Protocol 不仅可以修饰 class 还可以用于 struct 和 enum, 由于这个原因为了通用性我们可以将 protocol 中方法声明为 mutating

protocol Vehicle {
    var numberOfWheels: Int {get}
    var color: UIColor {get set}
    
    mutating func changeColor()
}

struct MyCar: Vehicle {
    let numberOfWheels = 4
    var color = UIColor.blue
    
    mutating func changeColor() {
        color = .red
    }
}

// 在 class 中实现包含 mutating 的方法协议时，具体的实现前面不需要添加 mutating 修饰
// 因为 class 可以随意更改自己的成员变量
// 所以在协议中使用 mutating 对应 class 完全透明

//: [Next](@next)
