//
//  ViewController.swift
//  MatchPortStudy
//
//  Created by Liang on 2018/1/17.
//  Copyright © 2018年 Liang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var eventMachPort: NSMachPort!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addMachPortToMainRunloop()
    }
    
    private func addMachPortToMainRunloop() {
        eventMachPort = NSMachPort()
        eventMachPort.setDelegate(self)
        RunLoop.current.add(eventMachPort, forMode: .commonModes)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 开启一个子线程，子线程通过Port与主线程进行通信
        DispatchQueue.global().async {
            guard let port = self.eventMachPort else {
                return
            }
            Thread.current.name = "com.port.subThread"
            print("Sub Thread \(Thread.current)")
            // 往主线程Runloop发送事件
            port.send(before: Date(), msgid: 100, components: nil, from: nil, reserved: 0)
            port.send(before: Date(), components: nil, from: nil, reserved: 0)
        }
    }
}

extension ViewController: NSMachPortDelegate {
    func handleMachMessage(_ msg: UnsafeMutableRawPointer) {
        print("Handle Event \(Thread.current)")
    }
}

