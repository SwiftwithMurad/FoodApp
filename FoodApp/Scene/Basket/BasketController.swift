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
    let manager = FileManagerHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        addFooter()
    }
    
    func configUI() {
        title = "Basket"
        
        basketTableView.dataSource = self
        basketTableView.delegate = self
        
        basketTableView.register(UINib(nibName: "\(BasketCell.self)", bundle: nil), forCellReuseIdentifier: "\(BasketCell.self)")
        print(addedFoods)
        manager.readData { basket in
            addedFoods = basket
        }
    }
    
    func addFooter() {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30))
        let label = UILabel(frame: footer.bounds)
        label.text = "Total Price:"
        label.textAlignment = .center
        footer.addSubview(label)
        basketTableView.tableFooterView = footer
    }
}

extension BasketController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addedFoods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(BasketCell.self)") as! BasketCell
        let data = addedFoods[indexPath.row]
        let price = (Double(data.price ?? "") ?? 0.0) * Double(data.count ?? 0)
        cell.configure(price: "\(addedFoods[indexPath.row].currency ?? "")\(price)",
                       foodName: addedFoods[indexPath.row].name ?? "",
                       cellImage: addedFoods[indexPath.row].image ?? "",
                       count: "Count: \(addedFoods[indexPath.row].count ?? 0)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            addedFoods.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            manager.writeBasketData(basket: addedFoods)
            tableView.endUpdates()
        }
    }
}
