import UIKit

protocol A {
	func p()
}

protocol B {
	func p()
}

extension A {
	func p() {
		print("A")
	}
}

extension B {
	func p() {
		print("B")
	}
}

class C: A, B {
}

let a: A = C()
a.p()
