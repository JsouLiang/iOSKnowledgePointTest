//
//  ProfileRoute.swift
//  Portal-Swift
//
//  Created by Liang on 2018/4/23.
//  Copyright © 2018年 Liang. All rights reserved.
//

import UIKit

protocol ProfileRoute {
	func openProfile(for user: User)
}

extension ProfileRoute where Self: UIViewController {
	func openProfile(for user: User) {
		let profileViewController = UIViewController()
		present(profileViewController, animated: true, completion: nil)
	}
}
