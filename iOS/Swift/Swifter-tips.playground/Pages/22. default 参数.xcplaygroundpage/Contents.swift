//: [Previous](@previous)

import Foundation

// Swift 的⽅法是⽀持默认参数的，也就是说在声明⽅法时，可以给某个参数指定⼀个默认使⽤的 值。
func sayHello1(str1: String = "Hello", str2: String, str3: String) {
    print(str1 + str2 + str3)
}

func sayHello2(str1: String, str2: String, str3: String = "World") {
    print(str1 + str2 + str3)
}


//: [Next](@next)
