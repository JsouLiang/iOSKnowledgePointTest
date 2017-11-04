//: [Previous](@previous)

import Foundation

class Toy {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Pet {
    var toy: Toy?
}

class Child {
    var pet: Pet?
}

let xiaoming = Child()
// toyName 是 String? 类型，虽然 Toy 中 name 定义的为 String，但是 Optional Chaining 中间随时都有可能返回 nil
// 所以 toyName 是 String? 类型
let toyName = xiaoming.pet?.toy?.name

extension Toy {
    func play() {}
}
// play 返回值为(), 因为可选链返回值可空，所以下面这段可选链的返回值为()?
let action = xiaoming.pet?.toy?.play()
let playClosure = { (child: Child) -> ()? in
    return child.pet?.toy?.play()
}
// 我们需要通过Option binding 来判断是否调用成功
if let result = playClosure(xiaoming) {
    print("good")
} else {
    print("bad")
}

//: [Next](@next)
