//
//  BasketController.swift
//  FoodApp
//
//  Created by Mac on 10.12.24.
//

import UIKit

class BasketController: UIViewController {
    @IBOutlet private weak var basketTableView: UITableView!
    
    var addedFoods: [Foods] = []
    let foods = FoodsController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    func configUI() {
        title = "Basket"
        
        basketTableView.dataSource = self
        basketTableView.delegate = self
        
        basketTableView.register(UINib(nibName: "BasketCell", bundle: nil), forCellReuseIdentifier: "BasketCell")
    }
    
}

extension BasketController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addedFoods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketCell") as! BasketCell
        cell.configure(price: addedFoods[indexPath.row].price ?? "", foodName: addedFoods[indexPath.row].name ?? "", cellImage: addedFoods[indexPath.row].image ?? "", count: addedFoods[indexPath.row].price ?? "")
        return cell
    }
}

//'invalid nib registered for identifier (BasketCell) - nib must contain exactly one top level object which must be a UITableViewCell instance'
