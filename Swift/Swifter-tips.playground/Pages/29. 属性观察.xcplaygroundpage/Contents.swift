//: [Previous](@previous)

import Foundation

// 利⽤属性观察我们可以在当前类型 内监视对于属性的设定，并作出⼀些响应。
// 在 willSet 和 didSet 中我们分别可以使⽤ newValue 和 oldValue 来获取将要设定的和已经设定 的值。
class MyClass {
    var date: NSDate {
        willSet {
            let d = date
            print("即将将⽇期从 \(d) 设定⾄ \(newValue)")
        }
        didSet {
            print("已经将⽇期从 \(oldValue) 设定⾄ \(date)")
        }
    }
    init() {
        date = NSDate()
    }
}
let foo = MyClass()
foo.date = foo.date.addingTimeInterval(10086)
// 我们无法对一个计算属性添加willset 和 didset，但是我们可以在计算属性中的 set 和 get 中完成相应的操作

// 如果我们⽆法改动这个类，⼜想 要通过属性观察做⼀些事情的话，可能就需要⼦类化这个类，
// 并且重写它的属性了。
// 重写的属性 并不知道⽗类属性的具体实现情况，⽽只从⽗类属性中继承名字和类型，
// 因此在⼦类的重载属性 中我们是可以对⽗类的属性任意地添加属性观察的，
// ⽽不⽤在意⽗类中到底是存储属性还是计算 属性：
class A {
    var number: Int {
        get {
            print("get")
            return 1
        }
        set { print("set")}
    }
}

class B: A {
    override var number: Int {
        willSet {print("willSet") }
        // didSet 中用到 oldValue 这个值需要先进行一次 get 操作，要确保值的正确性
        didSet { print("didSet") }
    }
}


let b = B()
b.number = 10
print(b.number)
/*
 get
 willSet
 set
 didSet
 get
 
 注意的是 get ⾸先被调⽤了⼀次。 这是因为我们实现了 didSet ， didSet 中会⽤到 oldValue ，
 ⽽这个值需要在整个 set 动作之前进⾏获取并存储待⽤，否则将⽆法确保正确性。
 如果我们不实现didSet 的话，这个 get 操作也不存在。
 */
//: [Next](@next)
