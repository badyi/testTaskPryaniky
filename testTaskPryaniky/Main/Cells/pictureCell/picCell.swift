//
//  picCell.swift
//  testTaskPryaniky
//
//  Created by и on 01.10.2020.
//  Copyright © 2020 badyi. All rights reserved.
//

import UIKit

final class PicCell: CellBase {
    
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var txtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension PicCell{
    func setupView() {
        guard let txt = model?.text() else { return }
        txtLabel.text = txt
        
        guard let data = model?.imageData() else { return }
        guard let img = UIImage(data: data) else { return }
        pic.image = img
    }
}
