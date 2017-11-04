//: [Previous](@previous)

import Foundation
//: 计算属性
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
}
let aMarathon = 42.km + 195.m

//: 构造器
struct Size {
    var width = 0.0, height = 0.0
}

struct Point {
    var x = 0.0 , y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
}
// 对于值类型结构体来说，原始实现中未定义任何定制的构造器且所有存储属性 提供了默认值，
// 那么我们可以获得一个 默认构造器和一个逐一成员构造器这样两个指定构造器
let size = Size()
let sizeII = Size(width: 10, height: 10)
let point = Point()
let rect = Rect()
let rectII = Rect(origin: point, size: size)

extension Rect {
    init(center: Point, size: Size) {
        let originalX = center.x - (size.width) * 0.5
        let originalY = center.y - (size.height) * 0.5
        // 调用逐一成员构造器
        self.init(origin: Point(x: originalX, y: originalY), size: size)
    }
}

class Person {
    enum Sex {
        case male
        case female
    }
    var name: String?
    var sex:Sex = .male
}
// 不定义 extension 只有一个初始化方法 Person()
extension Person {
    // class 类型的init extension 必须添加 convenience
    convenience init(name: String, sex: Person.Sex) {
        self.init()
        self.name = name
        self.sex = sex
    }
}
// 此时 Person 具有 Person 和 Person(name: sex:) 两个初始化方法
class Man: Person {
    var power: Double
    var height: Double
    init(power: Double) {
        self.power = power
        self.height = 0.0
//        父类属性必须要在调用玩 super 的指定构造函数后赋值
//        self.sex = .male
//        self.name = "name"
        super.init()
        self.sex = .male
        self.name = "name"
//        super.init(name: "Man", sex: .male)   只能调用父类的指定初始化方法
    }
    
    init(height: Double) {
        self.height = height
        self.power = 0.0
        // 在调用父类的 super 之前，子类的属性都应该设置完毕
        super.init()
        self.sex = .male
        self.name = "name"
    }
    
}

extension Man {
    convenience init(name: String, power: Double) {
        // convenience init 只能调用自己类的指定构造函数
        self.init(power: power)
        self.name = name
        self.sex = .male
        
    }
}

//: extension 方法, 下标, 嵌套类型
extension Int {
    // extension 方法
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
    
    mutating func square() {
        self = self * self
    }
    // 下标
    subscript(index: Int) -> Int {
        var base = 1
        for _ in 0 ..< index {
            base *= 10
        }
        return (self / base) % 10
    }
    // 嵌套类型
    enum Kind {
        case negative, zero, postive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let value where value > 0:
            return .postive
        default:
            return .negative
        }
    }
}

protocol Protocol {
    func doAction()
}

extension Int: Protocol {
    func doAction() {
        print("do action")
    }
}

//: [Next](@next)
