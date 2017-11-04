//: [Previous](@previous)

import Foundation

// Swift 的 for...in 可以在所有实现了 Sequence 的类型上
// 而为了实现 Sequence 首先需要实现一个 IteratorProtocol

class ReverseIterator<T>: IteratorProtocol {
    typealias Element = T
    var array: [Element]
    var currentIndex = 0
    init(array: [Element]) {
        self.array = array
        currentIndex = array.count - 1
    }
    
    func next() -> Element? {
        if currentIndex < 0 {
            return nil
        } else {
            let element = array[currentIndex]
            currentIndex -= 1
            return element
        }
    }
}

struct ReverseSequence<T>: Sequence {
    var array: [T]
    init(array: [T]) {
        self.array = array
    }
    
    typealias Iterator = ReverseIterator<T>
    func makeIterator() -> ReverseIterator<T> {
        return ReverseIterator(array: self.array)
    }
}
let arr = [0, 1, 2, 3, 4]

//let iterator = ReverseSequence(array: arr).makeIterator()
////while(iterator.next() != nil) {
////    print(arr[iterator.currentIndex])
////}
//
//for i in arr {
//    print(i)
//}

for i in ReverseSequence(array: arr) {
    print("index \(i) is \(arr[i])")
}

//: [Next](@next)
