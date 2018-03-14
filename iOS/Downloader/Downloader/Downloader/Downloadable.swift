//
//  Downloadable.swift
//  Downloader
//
//  Created by Liang on 2018/3/7.
//  Copyright © 2018年 Liang. All rights reserved.
//

import UIKit

enum DownloadedSourceStatus {
	case none				// 初始状态
	case running			// 正在下载
	case suspended			// 暂停下载
	case completed			// 下载结束
	case failed				// 下载失败
	case waiting			// 等待下载
	case canceled  			// 取消下载
}



protocol Downloadable: NSObjectProtocol {
	//	资源URL
	var sourceURL: URL {get}
	/// 下载的进度
	var progress: Float {set get}
	
	var resumeData: Data? {set get}
	
	var downloadStatus: DownloadedSourceStatus { set get}
	
	var saveFilePath: URL { get }
}

extension Downloadable {
	/// 完整文件大小
	var totalExceptedFileSize: ((String) -> ())? {
		return nil
	}
	/// 下载进度
	var trackProgressOption: ((Float) -> ())? {
		return nil
	}
	
	var resumeData: Data? {
		return nil
	}
	
	var saveFilePath: URL {
		let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
		return documentsPath.appendingPathComponent(sourceURL.lastPathComponent)
	}
}

