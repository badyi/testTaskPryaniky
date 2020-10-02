// Протоколы для Optional. Необходим для определения Optional в Generic-ах

import Foundation

public protocol OptionalType: ExpressibleByNilLiteral {
	associatedtype Wrapped
	var optionalValue: Wrapped? { get }
}

extension Optional: OptionalType {
	public var optionalValue: Wrapped? {
		return self
	}
}
