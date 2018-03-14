//
//  ViewController.swift
//  Downloader
//
//  Created by Liang on 2018/3/7.
//  Copyright © 2018年 Liang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
}

extension ViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "DownloadInfoCellTableViewCell", for: indexPath)
		return cell
	}
}

