//
//  MainService.swift
//  testTaskPryaniky
//
//  Created by и on 28.09.2020.
//  Copyright © 2020 badyi. All rights reserved.
//

import UIKit

protocol MainServiceProtocol {
    func load (completionBlock: @escaping(OperationCompletion<MainListModel>) -> ())
}

final class MainResourceFactory {
    func createMainResource() -> Resource<Response> {
        return Resource(url: URL(string: "https://pryaniky.com/static/json/sample.json")!, headers: nil);
    }
    
    func createImageResource(for urlString: String) -> Resource<Data>? {
        guard let url = URL(string: urlString) else { return nil }
        
        let parse: (Data) throws -> Data = { data in
            return data
        }
        
        return Resource<Data>(url: url, method: .get, parse: parse)
    }
}

final class FakeReachability: ReachabilityProtocol {
    var isReachable: Bool = true
}

// MARK: - Service
final class MainService: MainServiceProtocol {
    let networkHelper = NetworkHelper(reachability: FakeReachability())
    
    func load (completionBlock: @escaping(OperationCompletion<MainListModel>) -> ()) {
        _ = networkHelper.load(resource: MainResourceFactory().createMainResource()) { result in
            switch result {
            case let .success(response):
                let listOfModels: [MainModel] = response.data.map { MainModel(with: $0.name, $0.data.text, $0.data.url, $0.data.selectedID, $0.data.variants)}
                let mlmodel = MainListModel(with: response.view, listOfModels: listOfModels)
                completionBlock(.success(mlmodel))
            case let .failure(error):
                completionBlock(.failure(error))
            }
        }
    }
}

// MARK: - Response
struct Response: Codable {
    let data: [Datum]
    let view: [String]
}

// MARK: - Datum
struct Datum: Codable {
    let name: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable{
    let text: String?
    let url: String?
    let selectedID: Int?
    let variants: [Variant]?
}

// MARK: - Variant
struct Variant: Codable {
    let id: Int
    let text: String
}
