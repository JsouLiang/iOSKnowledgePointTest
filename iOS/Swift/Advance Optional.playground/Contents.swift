//: Playground - noun: a place where people can play

import UIKit

// MARK: - Quick Judge
extension Optional {
	// 判断optional是否为nil
	var isNone: Bool {
		return self == nil
	}
	// 判断optional是否有值
	var isSome: Bool {
		return self != nil
	}
}

// MARK: - Default Value
extension Optional {
	
	/// 如果可选值有值，返回可选值的值，否则返回 指定的默认值
	func or(_ default: @autoclosure () -> Wrapped) -> Wrapped {
		return self ?? `default`()
	}
	
	/// 如果可选值为nil时，throw一个 exception
	func or(throw exception: Error) throws -> Wrapped {
		guard let unwrapped = self else {
			throw exception
		}
		return unwrapped
	}
	
	
	/// 具有默认值的map操作
	func map<T>(_ fn: (Wrapped) throws -> T, default: @autoclosure () throws -> T) rethrows -> T {
		return try map(fn) ?? `default`()
	}
}

extension Optional where Wrapped == Error {
	func catchError(_ do: (Error) -> Void) {
		guard let error = self else { return }
		`do`(error)
	}
}

extension Optional {
	
	/// 尝试解包self，如果self有值将指定的可选值返回，如果self没有值返回nil
	/**
		使用and来简化流程
		let user: String?
		func userAccount() -> String? {
			return .none
		}
	
		if let _user = user, let account = userAccount() {}
		let account = user.and(userAccount())
	*/
	func and<B>(_ optional: B?) -> B? {
		guard self.isSome else { return nil }
		return optional
	}
	
	/**
	and(then) 简单使用：
	protocol UserDatabase {
		func current() -> User?
		func spouse(of user: User) -> User?
		func father(of user: User) -> User?
		func childCount(of user: User) -> Int?
	}
	
	extension UserDatabase {
		func current() -> User? {
			return nil
		}
	
		func spouse(of user: User) -> User? {
			return nil
		}
	
		func father(of user: User) -> User? {
			return nil
		}
	
		func childCount(of user: User) -> Int? {
			return 0
		}
	}
	
	struct Database: UserDatabase {}
	let database = Database()
	var childCount = 0
	if let currentUser = database.current(),
		let father1 = database.father(of: currentUser),
		let father2 = database.father(of: father1),
		let spouse = database.spouse(of: father2),
		let f2ChildCount = database.childCount(of: father2){
		childCount = f2ChildCount
	}
	
	let children = database.current()
	.and { database.father(of: $0) }
	.and { database.father(of: $0)}
	.and { database.spouse(of: $0) }
	.and { database.childCount(of: $0)}.or(0)
	*/
	func and<T>(then: (Wrapped) throws -> T?) rethrows -> T? {
		guard let unwrapped = self else {
			return nil
		}
		return try then(unwrapped)
	}
	
	func zip2<A>(with other: Optional<A>) -> (Wrapped, A)? {
		guard let first = self, let second = other else {
			return nil
		}
		return (first, second)
	}
	
	func zip3<A, B>(with other: Optional<A>, another: Optional<B>) -> (Wrapped, A, B)? {
		guard let first = self, let second = other, let third = another else {
			return nil
		}
		return (first, second, third)
	}
}

extension Optional {
	/// 当可选值有值时，指定一个操作
	func on(some: () throws -> Void) rethrows {
		if self.isSome {
			try some()
		}
	}
	
	/// 当可选值没有值时，指定一个操作
	func on(none: () throws -> Void) rethrows {
		if self.isNone {
			try none()
		}
	}
}

extension Optional {
	
	/**
		let opUser: User? = User()
		if let u = opUser, u.id < 100 {
			u.action()
		}
		opUser.filter { $0.id < 100 }?.action()
	*/
	/// 指定条件过滤Optional变量
	func filter(_ predicate: (Wrapped) -> Bool) -> Wrapped? {
		guard let unwrapped = self, predicate(unwrapped) else {
			return nil
		}
		return self
	}
	
	func except(_ message: String) -> Wrapped {
		guard let value = self else { fatalError(message) }
		return value
	}
}


func should(_ do: () throws -> Void) -> Error? {
	do {
		try `do`()
		return nil
	} catch let exception {
		return exception
	}
}

func throwingFucntion() throws -> Void {
	
}

should {  try throwingFucntion() }.catchError{print($0)}

let str: String? = nil
let str1: String? = .none
str.isNone
str1.isNone
str.or("123")

let optional1: String? = "appventure"
let optional2: String? = nil
print(optional1.map({$0.count}) ?? 0)
print(optional2.map({$0.count}) ?? 0)
print(optional1.map({$0.count}, default: 0))
print(optional2.map({$0.count}, default: 0))
print(optional2.map({$0.count}, default: "default".count))
struct User {
	var id: Int = 0
	func action() {
	}
}

protocol UserDatabase {
	func current() -> User?
	func spouse(of user: User) -> User?
	func father(of user: User) -> User?
	func childCount(of user: User) -> Int?
}

extension UserDatabase {
	func current() -> User? {
		return nil
	}
	
	func spouse(of user: User) -> User? {
		return nil
	}
	
	func father(of user: User) -> User? {
		return nil
	}
	
	func childCount(of user: User) -> Int? {
		return 0
	}
}

struct Database: UserDatabase {}
let database = Database()
var childCount = 0
if let currentUser = database.current(),
	let father1 = database.father(of: currentUser),
	let father2 = database.father(of: father1),
	let spouse = database.spouse(of: father2),
	let f2ChildCount = database.childCount(of: father2){
	childCount = f2ChildCount
}

let children = database.current()
			.and { database.father(of: $0) }
			.and { database.father(of: $0)}
			.and { database.spouse(of: $0) }
			.and { database.childCount(of: $0)}.or(0)

let opUser: User? = User()
if let u = opUser, u.id < 100 {
	u.action()
}
opUser.filter { $0.id < 100 }?.action()




