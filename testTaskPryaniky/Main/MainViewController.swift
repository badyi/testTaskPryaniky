//
//  ViewController.swift
//  testTaskPryaniky
//
//  Created by и on 28.09.2020.
//  Copyright © 2020 badyi. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

    let tableView = UITableView()
    
    var presenter: MainPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.load()
    }
    
    override func loadView() {
        super.loadView()
        self.navigationController?.navigationBar.topItem?.title = "PRYANIKY"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.orange]    
        setupTableView()
    }
}

// MARK: - vc setup view
extension MainViewController {
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "textCell", bundle: nil), forCellReuseIdentifier: "textCell")
        tableView.register(UINib(nibName: "picCell", bundle: nil), forCellReuseIdentifier: "picCell")
        tableView.register(UINib(nibName: "selectorCell", bundle: nil), forCellReuseIdentifier: "selectorCell")
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textCell") as! TextCell
        
        guard let model = presenter.model(at: indexPath) else { return cell }
        
        switch model.type() {
        case .hz:
            let cellText = tableView.dequeueReusableCell(withIdentifier: "textCell") as! TextCell
            cellText.setModel(with: model)
            cellText.setupView()
            return cellText
        case .picture:
            let cellPic = tableView.dequeueReusableCell(withIdentifier: "picCell") as! PicCell
            cellPic.setModel(with: model)
            cellPic.setupView()
            return cellPic
        case .selector:
            let cellSelect = tableView.dequeueReusableCell(withIdentifier: "selectorCell") as! SelectorCell
            cellSelect.setModel(with: model)
            cellSelect.setupView()
            return cellSelect
        default:
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let model = presenter.model(at: indexPath)
        model?.loadImageIfNeeded(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = presenter.model(at: indexPath) else { return }
        let vc = InfoViewController(with: model)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: MainViewProtocol {
    func dataDidLoaded() {
        tableView.reloadData()
    }
    
    func dataDidntLoaded() {
        
    }
    
    func reloadItem(at index: IndexPath) {
        tableView.reloadRows(at: [index], with: .top)
    }
}

