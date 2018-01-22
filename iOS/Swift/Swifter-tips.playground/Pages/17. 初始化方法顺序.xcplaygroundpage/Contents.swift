//: [Previous](@previous)

import Foundation

class Cat {
    var name: String
    init() {
        name = "cat"
    }
}

//: 子类初始化顺序
//: 1. 设置子类自己需要初始化的参数
//: 2. 调用父类相应的初始化方法, super.init()
//: 3. 对父类中需要改变的成员进行设定
//: 4. 如果我们没有对父类的成员进行修改，那么可以不用显示调用 super.init, Swift 会自动帮我们调用 super.init

class Tiger: Cat {
    let power: Int
    override init() {
        power = 10
        super.init()
        name = "tiger"
    }
}

//: [Next](@next)
