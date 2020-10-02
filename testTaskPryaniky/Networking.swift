// Протокол отправки запросов в сеть

import Foundation

protocol Networking {
    
	/// - Returns: возвращает объект для возможности отмены запроса
	func execute<A>(_ resource: Resource<A>, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Cancellation?
}

extension URLSession: Networking {
	func execute<A>(_ resource: Resource<A>, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Cancellation? {
		let request = URLRequest(resource: resource)
		let task = dataTask(with: request, completionHandler: completionHandler)
		task.resume()
		return task
	}
}
