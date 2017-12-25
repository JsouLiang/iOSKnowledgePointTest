//: [Previous](@previous)

import Foundation

// Swift 中 class 和 static 修饰的方法是类方法
// 但是 class 修饰的方法可以被子类修改，static 不能被子类修改
class A {
    static func method1() {
        print("A method1")
    }
    
    class func method2() {
        print("A method2")
    }
}

class B: A {
    /*
    override static func method1() {        // Error: cannot override static method
        print("A method1")
    }
    */
    
    override class func method2() {
        print("B method2")
    }
}

B.method1()
B.method2()

//: [Next](@next)
