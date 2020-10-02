//
//  selectorCell.swift
//  testTaskPryaniky
//
//  Created by и on 01.10.2020.
//  Copyright © 2020 badyi. All rights reserved.
//

import UIKit

final class SelectorCell: CellBase {

    @IBOutlet weak var picker: UIPickerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        picker.dataSource = self
        picker.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SelectorCell {
    func setupView() {
        picker.selectRow(model?.selectedID() ?? 0, inComponent: 0, animated: true)
    }
}

extension SelectorCell: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return model?.numberOfComponents() ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return model?.numberOfVariants() ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let variant =  model?.variants()?[row].text ?? ""
        return variant
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: super.contentView.frame.size.width, height: super.contentView.frame.size.height))
        if let v = view {
            label = v as! UILabel
        }
        
        label.font = UIFont (name: "Helvetica Neue", size: 17)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 2
        label.text = model?.variants()?[row].text ?? ""
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        model?.setSelected(row)
    }
}

