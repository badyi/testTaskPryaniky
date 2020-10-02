// Протокол описывающий возможность проверки наличия сети

import Foundation

/// Протокол описывающий возможность проверки наличия сети
public protocol ReachabilityProtocol {
	/// Доступна ли сеть
	var isReachable: Bool { get }
}
