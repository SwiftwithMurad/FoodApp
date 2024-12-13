//
//  HomeController.swift
//  FoodApp
//
//  Created by Mac on 07.12.24.
//

import UIKit

class HomeController: UIViewController {
    @IBOutlet private weak var homeCollection: UICollectionView!
    
    let homeView = HomeVievModel()
    let foods = FoodsController()
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configureUI()
        homeView.getUrl()
    }
    
    func configureUI() {
        title = "Home"
        
        homeCollection.dataSource = self
        homeCollection.delegate = self

        homeCollection.register(UINib(nibName: "FoodViewCell", bundle: nil), forCellWithReuseIdentifier: "FoodViewCell")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "basket.fill"), style: .plain, target: self, action: #selector(basketController))
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.fill"), style: .plain, target: self, action: #selector(profileController))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
}

extension HomeController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeView.foodModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodViewCell", for: indexPath) as! FoodViewCell
        cell.config(cellLabel: homeView.foodModel[indexPath.row].name ?? "", cellImage: homeView.foodModel[indexPath.row].image ?? "")
        cell.hideButton()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width / 2 - 32 , height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "FoodsController") as! FoodsController
        controller.setFoods(foods: homeView.foodModel[indexPath.row].category ?? [])
        controller.food = homeView.foodModel[indexPath.row]
        navigationController?.show(controller, sender: nil)
    }
    
    @objc func basketController() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "BasketController") as! BasketController
        navigationController?.show(controller, sender: nil)
    }
    
    @objc func profileController() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
        navigationController?.show(controller, sender: nil)
    }
}
