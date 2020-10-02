// Протокол для работы с сервером на основе ресурсов

import Foundation

/// Протокол для работы с сервером на основе ресурсов
public protocol NetworkHelperProtocol: class {
    /// - Returns: объект отмены операции загрузки данных
	func load<A>(resource: Resource<A>, completion: @escaping (OperationCompletion<A>) -> ()) -> Cancellation?
}
