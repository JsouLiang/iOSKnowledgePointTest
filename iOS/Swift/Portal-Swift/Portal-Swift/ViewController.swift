//
//  ViewController.swift
//  Portal-Swift
//
//  Created by Liang on 2018/4/23.
//  Copyright © 2018年 Liang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension UIViewController {
	/// 当有很多页面跳转的时候，它会变得很凌乱。
	func openProfile(/*Other Parameters*/) {
		/** Use other Parameter to initial UIViewCotroller*/
		let viewController = UIViewController()
		present(viewController, animated: true, completion: nil)
	}
}

