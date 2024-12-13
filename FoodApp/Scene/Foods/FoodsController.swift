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
    var yemek: Foods?
    var food: FoodCategory?
    let cell = FoodViewCell()
    
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
        readData()
    }
    
    func readData() {
        do {
            let data = try Data(contentsOf: getFilePath())
            foods = try JSONDecoder().decode([Foods].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getFilePath() -> URL {
        let files = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let path = files[0].appendingPathComponent("Foods.json")
        print(path)
        return path
    }
    
    func writeData(foods: [Foods]) {
        do {
            let data = try JSONEncoder().encode(foods)
            try data.write(to: getFilePath())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addItemToBasket(index: Int) {
        foods.append(foods[index])
        writeData(foods: foods)
    }
}

//MARK: Collection delegate
extension FoodsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodViewCell", for: indexPath) as! FoodViewCell
        cell.config(cellLabel: foods[indexPath.row].name ?? "", cellImage: foods[indexPath.row].image ?? "")
        cell.actionHandler = {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "BasketController") as! BasketController
            self.writeData(foods: self.foods)
            controller.addedFoods.append(contentsOf: self.foods)
            print("foods")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 190, height: 190)
    }
}
