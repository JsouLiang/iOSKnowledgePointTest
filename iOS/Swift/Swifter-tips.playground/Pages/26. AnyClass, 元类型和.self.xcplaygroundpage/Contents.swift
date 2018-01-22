//: [Previous](@previous)

import UIKit

// AnyClass 在 Swift 中被定义为
// typealias AnyClass = AnyObject.Type

// 通过 AnyObject.Type 这种方式得到一个元类型
// A.Type 表示 A 这个类型的元类型，也就是声明一个元类型来存储 A 这个类型本身；
// 从 A 中取出其类型时使用 .self

// A.Type 是类型
// A.self 是值
class A {
    static func method() {
        print("Hello")
    }
}

let metaA: A.Type = A.self
metaA.method()

let a = A()
let t: A = a.self

// 因为 AnyClass 就是 AnyObject.Type 所以我们可以按如下改写
let metaAII: AnyClass = A.self
(metaAII as! A.Type).method()
let tt = (metaAII as! A.Type)

class MusicViewController: UIViewController {}
class AlbumViewController: UIViewController {}
let usingVCTypes: [AnyClass] = [MusicViewController.self, AlbumViewController.self]

func setupViewControllers(_ vcTypes: [AnyClass]) {
    for vcType in vcTypes {
        if vcType is UIViewController.Type {
            let vc = (vcType as! UIViewController.Type).init()
            print(vc)
        }
    }
}

//: [Next](@next)
