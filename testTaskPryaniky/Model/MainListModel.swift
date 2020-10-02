//
//  MainListModel.swift
//  testTaskPryaniky
//
//  Created by и on 02.10.2020.
//  Copyright © 2020 badyi. All rights reserved.
//

import Foundation


protocol MainListModelProtocol {
    func count() -> Int
    func get(at index: IndexPath) -> MainModel?
    func listOfModels() -> [MainModel]
}

// MARK: - MainListModel
final class MainListModel: MainListModelProtocol {
    
    private var _view: [String]
    private var _listOfModels: [MainModel]
    
    
    init (with view: [String], listOfModels: [MainModel]) {
        self._view = view
        self._listOfModels = listOfModels
    }
    
    func count() -> Int {
        return _view.count
    }
    
    func get(at index: IndexPath) -> MainModel? {
        if index.row >= _view.count || index.row < 0 { return nil }
        let viewItemName = _view[index.row]
        return Algo.search(by: viewItemName, in: _listOfModels)
    }
    
    func listOfModels() -> [MainModel] {
        return _listOfModels
    }
}

final class Algo {
    static func search(by name: String, in list: [MainModel]) -> MainModel? {
        for i in list {
            if (name == i.name()) {
                return i
            }
        }
        return nil
    }
}
