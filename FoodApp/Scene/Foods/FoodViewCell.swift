//
//  FoodViewCell.swift
//  FoodApp
//
//  Created by Mac on 07.12.24.
//

import UIKit

class FoodViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var cellImageView: UIImageView!
    @IBOutlet private weak var cellLabel: UILabel!
    
    var actionHandler: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        actionHandler?()
    }
    
    func hideButton() {
        addButton.isHidden = true
    }
    
    func config(cellLabel: String, cellImage: String) {
        self.cellImageView.image = UIImage(named: cellImage)
        self.cellLabel.text = cellLabel
    }
}
