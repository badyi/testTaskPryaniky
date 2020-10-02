//
//  MainPresenter.swift
//  testTaskPryaniky
//
//  Created by и on 28.09.2020.
//  Copyright © 2020 badyi. All rights reserved.
//

import Foundation

protocol MainViewProtocol: class {
    func dataDidLoaded()
    func dataDidntLoaded()
    func reloadItem(at index: IndexPath)
}

protocol MainPresenterProtocol: class {
    func viewDidLoad()
    func count() -> Int
    func load()
    func model(at index: IndexPath) -> MainModel?
}

final class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    private var service: MainServiceProtocol?
    private var model: MainListModelProtocol?
    
    init(view: MainViewProtocol, service: MainServiceProtocol) {
        self.view = view
        self.service = service
    }
    
    func viewDidLoad() {
        
    }
    
    func load() {
        service?.load() { [weak self] result in
            switch result {
            case let .success(result):
                for i in result.listOfModels() {
                    i.delegate = self
                }
                DispatchQueue.main.async {
                    self?.model = result
                    self?.view?.dataDidLoaded()
                }
            case let .failure(error):
                print(error)
                DispatchQueue.main.async {
                    self?.view?.dataDidntLoaded()
                }
            }
        }
    }
    
    func count() -> Int {
        return model?.count() ?? 0
    }
    
    func model(at index: IndexPath) -> MainModel? {
        return model?.get(at: index)
    }
    
    func didEndDisplaying(at index: IndexPath) {
        let m = model(at: index)
        m?.cancelLoadImage()
    }
}

extension MainPresenter: ModelDelegate {
    func reload(at index: IndexPath) {
        DispatchQueue.main.async {
            self.view?.reloadItem(at: index)
        }
    }
}
