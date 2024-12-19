//
//  BasketCell.swift
//  FoodApp
//
//  Created by Mac on 10.12.24.
//

import UIKit

class BasketCell: UITableViewCell {
    @IBOutlet private weak var foodCount: UILabel!
    @IBOutlet private weak var foodPrice: UILabel!
    @IBOutlet private weak var foodName: UILabel!
    @IBOutlet private weak var cellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    
    }
    
    func configure(price: String, foodName: String, cellImage: String, count: String) {
        self.foodName.text = foodName
        self.foodPrice.text = price
        self.foodCount.text = count
        self.cellImage.image = UIImage(named: cellImage)
    }
}
