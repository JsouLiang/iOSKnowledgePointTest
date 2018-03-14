//
//  DownloadInfoCellTableViewCell.swift
//  Downloader
//
//  Created by Liang on 2018/3/13.
//  Copyright © 2018年 Liang. All rights reserved.
//

import UIKit

class DownloadInfoCellTableViewCell: UITableViewCell {
	
	var downloadModel: DownloadedModel?
	
	@IBOutlet weak var nameLabel: UILabel!
	
	@IBAction func startDownload(_ sender: Any) {
		
	}
	
	@IBAction func pauseDownload(_ sender: Any) {
	}
	
	@IBAction func cancelDownload(_ sender: Any) {
	}
}
