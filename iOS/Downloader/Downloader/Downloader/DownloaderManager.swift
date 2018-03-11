//
//  DownlerManager.swift
//  Downloader
//
//  Created by Liang on 2018/3/11.
//  Copyright © 2018年 Liang. All rights reserved.
//

import UIKit

class DownloaderManager: NSObject {
//	private let queue: OperationQueue
//	private let downloadSession: URLSession
//	override init() {
//		queue = OperationQueue()
//		queue.maxConcurrentOperationCount = 4
//		let sessionConfig = URLSessionConfiguration()
//		downloadSession = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
//		super.init()
//	}
}

extension DownloaderManager {
	func start(_ downloader: Downloadable) {
//		let operation = FilesDownloadOperation(downloadedModel: downloader, session: downloadSession)
		
	}
}

extension DownloaderManager: URLSessionDownloadDelegate {
	func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
		
	}
	
	func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
		
	}
	
	func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
		
	}
	
	func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
		
	}
}
