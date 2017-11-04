//: Playground - noun: a place where people can play

import UIKit

// 简单函数：将数字加1
func addOne(num: Int) -> Int {
    return num + 1
}
// 之后 +2，+3... 就需要在不断地编写代码重复的代码
// 使用函数式思维编写
func addTo(_ adder: Int) -> (Int) -> Int {
    return {
        return adder + $0
    }
}
let addTwo = addTo(2)
addTwo(4)
// 继续拓展
let addThree = addTo(3)
addThree(4)

// 比较大小
func greaterThan(_ comparer: Int) -> (Int) -> Bool {
    return {
        $0 > comparer
    }
}
let greaterThanTen = greaterThan(10)
greaterThanTen(13)
greaterThanTen(9)


// 封装 Target-Action
protocol TargetAction {
    func performAction()
}

struct TargetActionWrapper<T: AnyObject>: TargetAction {
    weak var target: T?
    
    let action: (T) -> () -> ()
    
    func performAction() -> () {
        if let t = target {
            action(t)()
        }
    }
}
enum ControlEvent {
    case touchUpInside
    case valueChange
}

class Control {
    var actions = [ControlEvent: TargetAction]()
    
    func set<T: AnyObject>(target: T,
                           action: @escaping (T) -> () -> (),
                     controlEvent: ControlEvent)  {
        actions[controlEvent] = TargetActionWrapper(target: target, action: action)
    }
    
    func removeTargetForControlEvent(controlEvent: ControlEvent) {
        actions[controlEvent] = nil
    }
    
    func performActionForControlEvent(controlEvent: ControlEvent) {
        actions[controlEvent]?.performAction()
    }
}

class MyViewController: UIViewController {
    let button = Control()
    
    override func viewDidLoad() {
        button.set(target: self,
                   action: MyViewController.onButtonTap,
                   controlEvent: .touchUpInside)
    }
    
    func onButtonTap() {
        print("Button was tapped")
    }
}
































