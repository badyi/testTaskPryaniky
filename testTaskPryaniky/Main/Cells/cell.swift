//
//  cell.swift
//  testTaskPryaniky
//
//  Created by и on 01.10.2020.
//  Copyright © 2020 badyi. All rights reserved.
//

import UIKit

class CellBase: UITableViewCell {
    var model: MainModel?
    
    func setModel(with model: MainModel) {
        self.model = model
    }
}

