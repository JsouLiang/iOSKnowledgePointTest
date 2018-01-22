//: [Previous](@previous)

import Foundation

protocol Food {}

protocol Animal {
    // 定义类型占位符，让实现协议的类型来指定具体的类型
    associatedtype F
    // eat 方法接收遵循 Food 协议的方法
    // F 类型可以被自动推断出来
    func eat(_ food: F)
}

struct Meat: Food {}
struct Grass: Food {}

struct Tigger: Animal {
    func eat(_ food: Meat) {
        print("eat \(food)")
    }
}

struct Sheep: Animal {
    func eat(_ food: Grass) {
        print("eat \(food)")
    }
}
// 在⼀个协议加⼊了像是 associatedtype 或者 Self 的约束后，它将只能被⽤为泛型约束，⽽不能作为独⽴类型的占位使⽤，也失去了动态派发的特性。
func isDangerous<T: Animal>(animal: T) -> Bool {
    if animal is Tigger {
        return true
    } else {
        return false
    }
}


//: [Next](@next)
