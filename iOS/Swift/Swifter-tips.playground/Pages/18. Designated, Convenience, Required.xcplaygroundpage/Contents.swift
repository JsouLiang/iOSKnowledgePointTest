//: [Previous](@previous)

import Foundation

class ClassA {
    let numA: Int
    var num: Int
    // 如果我们希望子类中一定实现某个 designated 初始化方法，我们可以通过添加 required 关键字进行限制
    // 强制子类对这个方法进行重写实现;
    // 这样做的最⼤的好处是可以保证依赖于某个 designated 初始化⽅法的 convenience ⼀直可以被使⽤。
    required init(num: Int) {
        numA = num
        self.num = num
    }
    // convenience 关键字的初始化⽅法。这类⽅法 是 Swift 初始化⽅法中的 “⼆等公⺠”，只作为补充和提供使⽤上的⽅便。
    // 所有的 convenience 初始化⽅法都必须调⽤同⼀个类中的 designated 初始化完成设置，
    // 另外convinence 初始化方法不能被⼦类重写或者是从⼦类中以 super 的⽅式被调⽤的
    convenience init(bigNum: Bool) {
        self.init(num: bigNum ? 1000: 1)
    }
    
    // required convenience 初始化子类可以不必实现
    convenience required init() {
        self.init(num: 10)
        num = 10
    }
}

class ClassB: ClassA {
    let numB: Int
    // 只要在⼦类中实现重写了⽗类 convenience ⽅法所需要的 init ⽅法的话，我们在⼦类中就也可以 使⽤⽗类的 convenience 初始化⽅法了
    override required init(num: Int) {
        numB = num + 1
        super.init(num: num)
    }
    
//    override convenience required init() {
//        self.init(num: 10)
//    }
}
ClassB(bigNum: true)

//: [Next](@next)
