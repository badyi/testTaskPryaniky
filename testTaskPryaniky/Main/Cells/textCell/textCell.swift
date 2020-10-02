//
//  textCell.swift
//  testTaskPryaniky
//
//  Created by и on 01.10.2020.
//  Copyright © 2020 badyi. All rights reserved.
//

import UIKit

final class TextCell: CellBase {

    @IBOutlet weak var txtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension TextCell {
    func setupView() {
        guard let txt = model?.text() else { return }
        txtLabel.text = txt
    }
}
