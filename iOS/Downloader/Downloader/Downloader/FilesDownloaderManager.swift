//
//  FilesDownloaderManager.swift
//  Downloader
//
//  Created by Liang on 2018/3/13.
//  Copyright © 2018年 Liang. All rights reserved.
//

import UIKit

class FilesDownloaderManager: NSObject {
	
	private lazy var downloadMap = {
		return [String: FilesDownloaderOperation]()
	}()
	
	private var downloadItemInfos: [Downloadable] {
		didSet {
			downloadItemInfos.forEach { (downloadItem) in
				self.addDownloadItem(downloadItem)
			}
		}
	}
	var maxConcurrentOperationCount: Int = 5
	private let queue: OperationQueue
	
	override convenience init() {
		self.init(downloadItemInfos: [])
	}
	
	init(downloadItemInfos: [Downloadable]) {
		self.downloadItemInfos = downloadItemInfos
		queue = OperationQueue()
		queue.maxConcurrentOperationCount = maxConcurrentOperationCount
		super.init()
	}
	
	/// suspend -> resume
	func continueDownloadInfo(info: Downloadable) {
		guard let operation = createOperation(info: info) else {
			return
		}
		operation.resume()
	}
	
	/// Donloading | Waiting -> Suspend
	func suspendDownload(info: Downloadable) {
		guard let operation = createOperation(info: info) else {
			return
		}
		operation.suspend()
	}
	
	func cancelDownload(info: Downloadable) {
		guard let operation = createOperation(info: info) else {
			return
		}
		operation.cancel()
	}
	
	/// begin
	func addDownloadItem(_ downloadItem: Downloadable) {
		if downloadMap[downloadItem.sourceURL.absoluteString] != nil {
			return
		}
		guard let operation = createOperation(info: downloadItem) else {
			return
		}
		downloadItemInfos.append(downloadItem)
		downloadMap[downloadItem.sourceURL.absoluteString] = operation
	}
	
	private func createOperation(info: Downloadable) -> FilesDownloaderOperation? {
		// check if completed
		if info.downloadStatus == .completed {
			return nil
		}
		// check if created
		guard let downloadOperation = downloadMap[info.sourceURL.absoluteString] else {
			// No create, create new operation
			let operation = FilesDownloaderOperation(downloadableInfo: info)
			operation.operationDelegate = self
			queue.addOperation(operation)
			return operation
		}
		
		return downloadOperation
	}
}

extension FilesDownloaderManager: FilesDownloaderOperationDelegate {
	
}
