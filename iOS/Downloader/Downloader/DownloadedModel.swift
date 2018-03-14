//
//  DownloadedModel.swift
//  Downloader
//
//  Created by Liang on 2018/3/7.
//  Copyright © 2018年 Liang. All rights reserved.
//

import UIKit

class DownloadedModel: NSObject, Downloadable {
	var resumeData: Data?
	var downloadStatus: DownloadedSourceStatus = .none
	var progress: Float = 0
	var sourceURL: URL
	
	init(sourceURL: URL) {
		self.sourceURL = sourceURL
	}
}
