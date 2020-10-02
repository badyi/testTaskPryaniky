//
//  MainModel.swift
//  testTaskPryaniky
//
//  Created by и on 29.09.2020.
//  Copyright © 2020 badyi. All rights reserved.
//

import Foundation

protocol ModelDelegate: class {
    func reload(at index: IndexPath)
}

enum TypeOfModel: String {
    case hz = "text"
    case picture = "picture"
    case selector = "selector"
    case undef
}

protocol MainModelProtocol {
    func numberOfVariants() -> Int
    func numberOfComponents() -> Int
    func type() -> TypeOfModel
    func text() -> String?
    func url() -> String?
    func selectedID() -> Int?
    func variants() -> [Variant]?
    func imageData() -> Data?
    func setSelected(_ row: Int)
    func name() -> String
}

// MARK: - Main model
final class MainModel: MainModelProtocol {
    
    private let _components: Int = 1
    private let _type: TypeOfModel
    private let _name: String
    private let _text: String?
    private var _url: String?
    private var _selectedId: Int?
    private let _variants: [Variant]?
    private var _imageData: Data?
    
    private var cancel: Cancellation?
    weak var delegate: ModelDelegate? 
    
    init(with name: String,_ text: String? = nil, _ url: String? = nil,_ selectedId: Int? = nil,_ variants: [Variant]? = nil) {
        switch name {
        case "hz":
            _type = .hz
        case "picture":
            _type = .picture
        case "selector":
            _type = .selector
        default:
            _type = .undef
        }
        
        _name = name
        _text = text
        _url = url
        _selectedId = selectedId
        _variants = variants
    }
    
    func name() -> String {
        return _name
    }
    
    func numberOfComponents() -> Int {
        return _components
    }
    
    func numberOfVariants() -> Int {
        return _variants?.count ?? 0
    }
    
    func type() -> TypeOfModel {
        return _type
    }
    
    func text() -> String? {
        return _text
    }
    
    func url() -> String? {
        return _url
    }
    
    func selectedID() -> Int? {
        return _selectedId
    }
    
    func variants() -> [Variant]? {
        return _variants
    }
    
    func imageData() -> Data? {
        return _imageData
    }
    
}

extension MainModel {
    func loadImageIfNeeded(_ index: IndexPath) {
        let helper = NetworkHelper(reachability: FakeReachability())
        
        if _imageData != nil || cancel != nil ||  _url == nil { return }
        guard let resource = MainResourceFactory().createImageResource(for: _url!) else { return }
        cancel = helper.load(resource: resource, completion: { [weak self] result in
            switch result {
                case .success(let imageData):
                    self?._imageData = imageData
                    DispatchQueue.main.async {
                        self?.delegate?.reload(at: index)
                    }
                case .failure(let error):
                    print(error)
            }
            self?.cancel = nil
        })
    }
        
    func cancelLoadImage() {
        cancel?.cancel()
        cancel = nil
    }
    
    func setSelected(_ row: Int) {
        _selectedId = row
    }
}
