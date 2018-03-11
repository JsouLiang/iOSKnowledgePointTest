//
//  State.swift
//  Downloader
//
//  Created by Liang on 2018/3/11.
//  Copyright © 2018年 Liang. All rights reserved.
//

import UIKit
enum StateValue: String {
	case ready = "isReady"
	case executing = "isExecuting"
	case finished = "isFinished"
	case cancel = "isCancelled"
	
	func value() -> String {
		return self.rawValue
	}
}

enum State {
	case ready(Bool)
	case executing(Bool)
	case finished(Bool)
	case cancel(Bool)
	
	func keyPath() -> String {
		switch self {
		case .ready:
			return StateValue.ready.rawValue
		case .executing:
			return StateValue.executing.rawValue
		case .finished:
			return StateValue.finished.rawValue
		case .cancel:
			return StateValue.cancel.rawValue
		}
	}
	
	var operationState: Bool {
		get {
			switch self {
			case .ready(let isReadied):
				return isReadied
			case .executing(let isExecuting):
				return isExecuting
			case .cancel(let isCancel):
				return isCancel
			case .finished(let isFinished):
				return isFinished
			}
		}
	}
}
