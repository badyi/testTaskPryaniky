// Протокол для объектов которые отменяют операции или какиее-то действия.

import Foundation

/// Протокол отмены операций
public protocol Cancellation {
	func cancel()
}

extension URLSessionTask : Cancellation {
	
}

/// Контейнер для отмены запросов, необходим для отмены цепочки запросов, когда объект отмены меняется
final public class RequestCancelContainer {
	/// Реальный объект отмены
	public var requestCancel: Cancellation?
	/// Флаг отменен или нет
	private(set) var isCanceled = false
}

extension RequestCancelContainer: Cancellation {
	public func cancel() {
		isCanceled = true
		requestCancel?.cancel()
	}
}
