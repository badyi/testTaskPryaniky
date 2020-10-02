//
//  Builder.swift
//  testTaskPryaniky
//
//  Created by и on 30.09.2020.
//  Copyright © 2020 badyi. All rights reserved.
//

import UIKit

protocol Builder {
    static func createMain() -> UIViewController
}

final class ModuleBuilder: Builder {
    static func createMain() -> UIViewController {
        let view = MainViewController()
        let service = MainService()
        let presenter = MainPresenter(view: view, service: service)
        view.presenter = presenter
        return view
    }
}
