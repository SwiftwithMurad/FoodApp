//
//  FoodsController.swift
//  FoodApp
//
//  Created by Mac on 10.12.24.
//

import UIKit

class FoodsController: UIViewController {
    @IBOutlet private weak var foodsCollection: UICollectionView!
    
    var foods: [Foods] = []
    var addedFoods: [Foods] = []
    var food: FoodCategory?
    let helper = FileManagerHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    func setFoods(foods: [Foods]) {
        self.foods = foods
    }
    
    func configUI() {
        title = food?.name
        foods = food?.category ?? []
        foodsCollection.dataSource = self
        foodsCollection.delegate = self
        foodsCollection.register(UINib(nibName: "FoodViewCell", bundle: nil), forCellWithReuseIdentifier: "FoodViewCell")
        helper.readData { foods in
            addedFoods = foods
        }
    }
    
    func addItemsToBasket(index: Int) {
        if let existingIndex = addedFoods.firstIndex(where: { $0.name == foods[index].name }) {
            addedFoods[existingIndex].count = (addedFoods[existingIndex].count ?? 1) + 1
        } else {
            addedFoods.append(foods[index])
        }
        helper.writeBasketData(basket: addedFoods)
    }
    
//
//    func updatePrice() {
//        if addedFoods.isEmpty {
//                totalPriceLabel.text = "You have no food in basket"
//            } else {
//                totalPriceLabel.text = "Total Price: \(totalPrice)$"
//            }
//        }
//        
//        func calculateTotalPrice() {
//            totalPrice = addedFoods.reduce(0) { $0 + ($1.price ?? "") * ($1.count ?? 1) }
//                updatePrice()
//        }
}
        


//MARK: Collection delegate
extension FoodsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodViewCell", for: indexPath) as! FoodViewCell
        cell.config(cellLabel: foods[indexPath.row].name ?? "",
                    cellImage: foods[indexPath.row].image ?? "")
        cell.actionHandler = {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "BasketController") as! BasketController
            controller.addedFoods = self.addedFoods
            self.addItemsToBasket(index: indexPath.row)
            print(self.addedFoods)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 190, height: 190)
    }
}

