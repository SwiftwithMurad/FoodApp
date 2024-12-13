//
//  BasketCell.swift
//  FoodApp
//
//  Created by Mac on 10.12.24.
//

import UIKit

class BasketCell: UITableViewCell {

    
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var foodNameLabel: UILabel!
    @IBOutlet private weak var cellImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }
    
    func configure(price: String, foodName: String, cellImage: String) {
        self.priceLabel.text = price
        self.foodNameLabel.text = foodName
        self.cellImage.image = UIImage(named: cellImage)
    }
}
