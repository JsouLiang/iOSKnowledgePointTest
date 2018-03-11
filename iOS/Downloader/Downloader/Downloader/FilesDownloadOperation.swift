//
//  FilesDownloadOperation.swift
//  Downloader
//
//  Created by Liang on 2018/3/7.
//  Copyright © 2018年 Liang. All rights reserved.
//

import UIKit
let TimeOutInterval = 60.0

/**
As a result, operations are always executed on a separate thread,
regardless of whether they are designated as asynchronous or synchronous operations.
来自-OperationQueue文档
说明：每个Operation都会被放到一个特定的线程，不管Operation是同步的还是异步的
*/
class FilesDownloadOperation: Operation {
	
	unowned let downloadedModel: Downloadable
	let session: URLSession
	private var task: URLSessionDownloadTask? {
		willSet {
			guard let newValue = newValue, let prevTask = task else {
				return
			}
			prevTask.removeObserver(self, forKeyPath: "status")
			newValue.addObserver(self, forKeyPath: "status", options: [.new, .old], context: nil)
		}
	}
	
	init(downloadedModel: Downloadable, session: URLSession) {
		self.downloadedModel = downloadedModel
		self.session = session
	}
	
	private var _changeStateOption: (() -> ())?
	
	fileprivate var state = State.ready(true) {
		willSet {
			willChangeValue(forKey: state.keyPath())
			willChangeValue(forKey: newValue.keyPath())
		}
		
		didSet {
			didChangeValue(forKey: oldValue.keyPath())
			didChangeValue(forKey: state.keyPath())
		}
	}
	
	deinit {
		task = nil
	}
}
// MARK: oerride principal method
extension FilesDownloadOperation {
	
	override func start() {
		// we can direct call start() and queue can automic call start()
		// which may be produce multithreading problem
		objc_sync_enter(self)
		if self.isCancelled {
			state = State.finished(true)
			objc_sync_exit(self)
			return
		}
		
		if downloadedModel.resumeData != nil {
			createResumeDataTask()
		} else {
			createNewRequestTask()
		}
		objc_sync_exit(self)
		
		if let task = task {
			task.resume()
			state = .executing(true)
			downloadedModel.downloadStatus = .running
		}
	}
	
	
	override func cancel() {
		if isFinished {
			return
		}
		super.cancel()
		guard let task = task else { return }
		// cancel task
		task.cancel()
		self.task = nil
		// stop executing
		if isExecuting { state = .executing(false) }
		// finished
		if isFinished == false { state = .finished(true) }
	}
	
}

// MARK : override
extension FilesDownloadOperation {
	
	override var isReady: Bool {
		return state.keyPath() == StateValue.ready.rawValue && state.operationState
	}
	
	override var isExecuting: Bool {
		return state.keyPath() == StateValue.executing.rawValue && state.operationState
	}
	
	override var isFinished: Bool {
		return state.keyPath() == StateValue.finished.rawValue && state.operationState
	}
	
	override var isCancelled: Bool {
		return state.keyPath() == StateValue.cancel.rawValue && state.operationState
	}
	
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		if keyPath == "status" {
			guard let task = task else { return }
			switch task.state {
			case .suspended :
				downloadedModel.downloadStatus = .suspended
			case .canceling:
				downloadedModel.downloadStatus = .canceled
			case .completed:
				if downloadedModel.progress == 1.0 {
					downloadedModel.downloadStatus = .completed
				} else {
					downloadedModel.downloadStatus = .suspended
				}
			case .running:
				downloadedModel.downloadStatus = .running
			}
		}
	}
}

extension FilesDownloadOperation {
	
	func suspend() {
		// Task not nil, operation executing
		guard let task = task, isExecuting else {
			// TODO: suspend 中Task为空时state的状态
			return
		}
		// cancel task, save resume data
		task.cancel(byProducingResumeData: { [weak self] (data) in
			defer { self?.task = nil }					// create new task in resume
			guard let `self` = self else {
				return
			}
			self.downloadedModel.resumeData = data		// 将resumeData保存至Model
			self.state = .executing(false)				// 修改正在执行状态
			self.downloadedModel.downloadStatus = .suspended
		})
		task.suspend()
	}
	
	func resume() {
		createResumeDataTask()
		guard let task = task else {
			return
		}
		task.resume()
		state = .executing(true)
	}
	
	
	func downloadFinished() {
		// stop executing
		if isExecuting { state = .executing(false) }
		// finished
		if isFinished == false { state = .finished(true) }
	}
}



extension FilesDownloadOperation {
	
	// create download request & task
	private func createNewRequestTask() {
		let request = URLRequest(url: downloadedModel.sourceURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: TimeOutInterval)
		task = session.downloadTask(with: request)
	}
	
	
	private func createResumeDataTask() {
		if downloadedModel.downloadStatus == .completed {
			return
		}
		downloadedModel.downloadStatus = .running
		objc_sync_enter(self)
		if downloadedModel.resumeData != nil {
			task = session.downloadTask(withResumeData: downloadedModel.resumeData!)
		} else if task == nil || task!.state == .completed && downloadedModel.progress < 1.0 {  // download files error
			createNewRequestTask()			// retry create request
		}
		objc_sync_exit(self)
	}
	
}


