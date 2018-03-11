//
//  FileDownloaderOperation.swift
//  Downloader
//
//  Created by Liang on 2018/3/11.
//  Copyright © 2018年 Liang. All rights reserved.
//

import UIKit

class FilesDownloaderOperation: Operation {
	private var session: URLSession!
	private var task: URLSessionDownloadTask?
	private let downloadableModel: Downloadable
	private var _finished: Bool = false {
		willSet {
			willChangeValue(forKey: "isFinished")
		}
		didSet {
			didChangeValue(forKey: "isFinished")
		}
	}
	private var _executing: Bool = false {
		willSet {
			willChangeValue(forKey: "isExecuting")
		}
		didSet {
			didChangeValue(forKey: "isExecuting")
		}
	}
	
	init(downloadableInfo: Downloadable) {
		downloadableModel = downloadableInfo
		// waiting...
		downloadableModel.downloadStatus = .waiting
		super.init()
		session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
	}
	
	override func start() {
		if isCancelled {
			_finished = true
			return
		}
		
		objc_sync_enter(self)
		// create task
		if task == nil {
			if downloadableModel.resumeData != nil {	// had resumeData
				task = session.downloadTask(withResumeData: downloadableModel.resumeData!)
			} else {	// don't have resume data
				task = session.downloadTask(with: downloadableModel.sourceURL)
			}
		}
		objc_sync_exit(self)
		// executing
		task!.resume()
		_executing = true
		downloadableModel.downloadStatus = .running
	}
	
	override func cancel() {
		if _finished { return }
		// unfinished，can be canceled
		super.cancel()
		downloadableModel.downloadStatus = .canceled
		if let task = task {
			task.cancel()
			if _executing { _executing = false }
			if _finished != true { _finished = true }
		}
		reset()
	}
	
	func suspancd() {
		if downloadableModel.downloadStatus == .running {
			task?.cancel { [weak self] (resumeData) in
				guard let `self` = self else { return }
				self._executing = false
				self.downloadableModel.resumeData = resumeData
				self.downloadableModel.downloadStatus = .suspended
			}
		}
		
	}
	
	func resume() {
		guard let resumeData = downloadableModel.resumeData else {
			return
		}
		task = session.downloadTask(withResumeData: resumeData)
		task!.resume()
		downloadableModel.downloadStatus = .running
		_executing = true
	}
}

extension FilesDownloaderOperation {
	override var isFinished: Bool {
		return _finished == true
	}
	
	override var isExecuting: Bool {
		return _executing == true
	}
	
	override var isConcurrent: Bool {
		return true
	}
}

extension FilesDownloaderOperation {
	private func reset() {
		if task != nil {
			task = nil
		}
		session.invalidateAndCancel()
		session = nil
	}
}

extension FilesDownloaderOperation:URLSessionDownloadDelegate {
	func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
		
	}
	
	func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
		
	}
	
	func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
		
	}
	
	func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
		
	}
}
