//: [Previous](@previous)

import UIKit

// typealias 是⽤来为已经存在的类型重新定义名字的，通过命名，可以使代码变得更加清晰。
typealias Location = CGPoint
typealias Distance = Double
func distance(from location: Location, to anotherLocation: Location) -> Distance {
    let dx = Distance(location.x - anotherLocation.x)
    let dy = Distance(location.y - anotherLocation.y)
    return sqrt(dx * dx + dy * dy)
}

// typealias 是单一的，必须制定某个特定的类型通过 typealias 赋值为新的名称，不能将整个泛型类进行重命名
class Person<T> {}
// Error
//typealias Worker = Person
//typealias Worker = Person<T>

// 我们在别名中也引⼊泛型
typealias Worker<T> = Person<T>

typealias WorkId = String
typealias SWorker = Person<WorkId>

// 使用 typealias 来合并协议
protocol Cat {}
protocol Dog {}
typealias Pat = Cat & Dog

//: [Next](@next)
