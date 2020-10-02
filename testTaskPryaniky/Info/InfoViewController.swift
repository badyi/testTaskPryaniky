//
//  InfoViewController.swift
//  testTaskPryaniky
//
//  Created by и on 02.10.2020.
//  Copyright © 2020 badyi. All rights reserved.
//

import UIKit

final class InfoViewController: UIViewController {
 
    private var presenter: InfoPresenter?
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInfo()
    }
    
    init(with model: MainModel) {
        presenter = InfoPresenter(with: model)
        super.init(nibName: "InfoViewController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        presenter = nil
        super.init(coder: aDecoder)
    }

    func setupInfo() {
        label1.text = "Info:"
        label1.textColor = .orange
        label2.text = "Name of object: " + (presenter?.getName() ?? "unknown")
        label3.text = "Type of content: " + (presenter?.getType().rawValue ?? "unknown")
    }
}

protocol InfoPresenterProtocol {
    func getName() -> String
    func getType() -> TypeOfModel
}

final class InfoPresenter: InfoPresenterProtocol {
    private let _model: MainModel
    
    init(with model: MainModel) {
        _model = model
    }
    
    func getName() -> String {
        return _model.name()
    }
    
    func getType() -> TypeOfModel {
        return _model.type()
    }
}
