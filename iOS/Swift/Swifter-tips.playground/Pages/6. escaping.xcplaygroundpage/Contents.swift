//: [Previous](@previous)

import Foundation

func doWork(block: () -> ()) {
    block()
}
doWork{
    print("Hello")
}
// doWork function 中 block 中的内容会在 doWork function 返回之前调用完成，即 block 与 doWork 是同步的
// 对于没有逃逸的闭包，因为闭包的作用域没有超过函数本身，所以我们不需要担心 block 中对self 的持有问题

// 将 block 放 到⼀个 Dispatch 中去，让它在 doWork 返回后被调⽤的话，
// 我们就需要在 block 的类型前加上 @escaping 标记来表明这个闭包是会“逃逸”出该⽅法的
// 而对于逃逸的闭包，因为其要保证闭包内成员在函数结束后仍然有效，所以需要对外部成员进行引用，如果要引用 self 的成员，必须要指明self
func doWorkAsync(block: @escaping () -> ()) {
    DispatchQueue.main.async {
        block()
    }
}


class Class {
    var hello = "Hello"
    func method1() {
        doWork {
            print(hello)    // Hello
        }
        hello = "bar"
    }
    
    func method2() {
        doWorkAsync {
            print(self.hello) // bar
        }
        hello = "bar"
    }
    
    func method3() {
        doWorkAsync { [weak self] in
            print(self?.hello)
        }
    }
}
let cls = Class()
cls.method1()
cls.method2()
cls.method3()

// 。如果你在协议或者⽗类中定义了⼀个接受 @escaping 参数⽅法，
//  那么在实现协议和类型或者是这个⽗类的⼦类中，对应的⽅法也必须被声明为 @escaping，否则两个⽅法会被认为拥有不同的函数签名
protocol P {
    func work(b: @escaping ()->())
}
class C : P {
    func work(b: @escaping () -> ()) {
        DispatchQueue.main.async {
            print("in C")
            b()
        }
    }
}

//class D: P {
//    func work(b: () -> ()) {        // Error
//        DispatchQueue.main.async {
//            print("in C")
//            b()
//        }
//    }
//}

//: [Next](@next)
