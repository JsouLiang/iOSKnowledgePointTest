//: [Previous](@previous)

import Foundation

class Pet {}
class Cat: Pet {}
class Dog: Pet {}

func printPet(_ pet: Pet) {
    print("Pet")
}

func printPet(_ cat: Cat) {
    print("cat")
}

func printPet(_ dog: Dog) {
    print("dog")
}

func printThem(_ pet: Pet, _ cat: Cat) {
    print("type: \(type(of: pet))")
    printPet(pet)
    printPet(cat)
}

printPet(Cat()) // cat
printPet(Dog()) // dog
printPet(Pet()) // Pet

// Swift 在编译期确定调用的方法，由于方法定义的第一个参数为 Pet 所有编译器就确定调用 第一个参数为 Pet 类型，即使运行时为 Dog 类型。Swift 编译器也会按编译器确定的类型调用
printThem(Dog(), Cat())


//: [Next](@next)
