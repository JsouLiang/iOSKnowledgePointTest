//: Playground - noun: a place where people can play

import UIKit
// : 属性
// 协议不指定属性是存储型属性还是计算型属性，它只指定属性的名称和类型。
// 此外，协议还指定属性是可读的还是可读可写的。
// 如果协议要求属性是可读可写的，那么该属性不能是常量属性或只读的计算型属性
// 如果协议只要求属性是可读的，那么该属性不仅可以是可读的，如果代码需要的话，还可以是可写的。
// 协议总是用 var 关键字来声明变量属性，在类型声明后加上 { set get } 来表示属性是可读可写的，可读属 性则用 { get } 来表示
protocol Protocol {
    var mustSettable: Int { set get }
//    let mustSettable: Int {set get}   常量属性不能是可读可写的
//    let gettableProperty: Int { get } 常量属性不能是 get 计算属性
    
    var doesNotNeetToBeSettable: Int { get }
    // 没有 只set的属性
//    var doesNotNeetToBeSettableI: Int { set }
}

class StarShip: Protocol {
    var mustSettable: Int
    var doesNotNeetToBeSettable: Int
    
    init(mustSettable: Int, doesNotNeetToBeSettable: Int) {
        self.mustSettable = mustSettable
        self.doesNotNeetToBeSettable = doesNotNeetToBeSettable
    }
}

// : Protocol Method
protocol MethodProtocol {
    func protocolFunction(vars: Int...)
    mutating func changeSelf()
}
class ClassI: MethodProtocol {
    func protocolFunction(vars: Int...) {
        
    }
    
    func changeSelf() {}
}

struct StructI: MethodProtocol {
    func protocolFunction(vars: Int...) {
    }
    mutating func changeSelf() {
    }
}

// : Protocol Initial
protocol InitialProtocol {
    // 实现该协议的类型的初始化方法，必须添加 required 关键字，表示类型或者类型子类必须要有这个初始化方法
    init(someParams: Int)
}
class SomeClass: InitialProtocol {
    //
    required init(someParams: Int) {
    }
}

class SomeClassSub: SomeClass {
    override required init(someParams: Int) {
        super.init(someParams: someParams)
    }
}

//let clas = SomeClassSub()

class SomeClassI: InitialProtocol {
    convenience required init(someParams: Int) {
        self.init()
    }
}
// 因为 final 类不能有子类，所以协议中的初始化方法可以不用 required
final class FinalClass: InitialProtocol {
    init(someParams: Int) {
        
    }
}

// : 协议作为类型
// : extends Protocol
protocol TextRepresentable {
    var textualDescription: String {get}
}

extension TextRepresentable {
    var textualDescription: String {
        return ""
    }
}

// : 协议继承
protocol SomeProtocol {}
protocol AnotherProtocol {}
protocol InheritingProtocol: SomeProtocol, AnotherProtocol { // 这里是协议的定义部分
}

// : 类类型专属协议
// 通过添加 class 关键字来限制协议只能被类类型采纳
protocol ClassProtocol: class {
    
}
// : 协议合成
// 有时候需要同时采纳多个协议，你可以将多个协议采用 SomeProtocol & AnotherProtocol 这样的格式进行组合，称为 协议合成(protocol composition)
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person: Named, Aged {
    var name: String
    var age: Int
}
// 协议合成协议合成并不会生成新的、永久的协议类型，而是将多个协议中的要求合成到一个只在局部作用域有效的临时协议中。
func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}
let birthdayPerson = Person(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)

// : 检查协议一致性
// 可以使用类型转换中的 is 和 as 操作符来检查协议一致性，即是否符合某协议，并可以转换到指定的协议类型
// is 检查某个实例是否符合某个协议，如果符合返回 true，否则返回 false
// as? 返回一个可选值，当实例符合某个协议时，返回类型为协议类型的可选值，否则返回 nil
// as! 将实例强制向下转换为某个协议类型，如果转换失败则会引起运行时错误
protocol HasArea {
    var area: Double {get}
}
class Circle: HasArea {
    let pi = 3.1415926
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) {
        self.radius = radius
    }
}
class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}
let circle = Circle(radius: 2)
print(circle is HasArea)    // true'

class Animal {
    var legs: Int
    init(legs: Int) {
        self.legs = legs
    }
}
let animal = Animal(legs: 4)
print(animal is HasArea) // false
print()
let objs: [AnyObject] = [
    circle,
    Country(area: 22),
    animal
]
for obj in objs {
    if let objHasArea = obj as? HasArea {
        print("\(objHasArea.area)")
    } else {
        print("No")
    }
}

// : 可选协议
@objc protocol CounterDataSource {
    @objc optional func incrementForCount(count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class DataSource: CounterDataSource {
    var fixedIncrement: Int = 3
}
let dataSource = DataSource()
let count = dataSource.fixedIncrement
let datas: [CounterDataSource] = [dataSource]
for data in datas {
    let cout = data.fixedIncrement      // 此处的 count 是 Int? 类型
    let value = data.incrementForCount?(count: count)   // 返回值为 Int?
}

class TowardsZeroSource:NSObject, CounterDataSource {
    func incrementForCount(count: Int) -> Int {
        if count == 0 { return 0 }
        else if count < 0 { return -1 }
        else { return -1 }
    }
}


class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.incrementForCount?(count: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

//: 协议扩展
// 提供默认实现
protocol PrettyTextRepresentable {
    var prettyTextualDescription: String { get }
}

extension PrettyTextRepresentable {
    var prettyTextualDescription: String {
        return ""
    }
}

// 为协议添加限制条件
protocol ImposeProtocol {
    func imposeFunction()
}
extension ImposeProtocol where Self: UIView {
    func imposeFunction() {}
}


extension Collection where Iterator.Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

