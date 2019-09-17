//
//  ViewController.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/14/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//

import UIKit
import Moya
import SDWebImage

class DrinksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let networkManager = NetworkManager()
    
    var drinksCategory: [DrinksCategory] = []
    var drinks: [Drinks] = []
    
    let drinkList: [String] = ["Ordinary_Drink", "Cocktail", "Cocoa", "Shot", "Ordinary_Drink", "Ordinary_Drink", "Ordinary_Drink", "Ordinary_Drink", "Ordinary_Drink", "Beer", "Ordinary_Drink"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let drinkCellNib = UINib(nibName: "DrinksTableViewCell", bundle: nil)
        tableView.register(drinkCellNib, forCellReuseIdentifier: "DrinksCell")
        
        // Получение категорий, передача в массив и далее вывод на экран
        networkManager.getDrinksCategory { [weak self] (drinks, error) in
            
            if let error = error {
                print("ERROR: \(error)")
                return
            }
            guard let drinks = drinks else { return }
            
            self?.drinksCategory = drinks
            self?.tableView.reloadData()
        }
        
        // Получение напитков для каждой категории (type -  передается название напитка, посдтавляется в параметры ссылки)
        // Не знаю как отобразить для каждой категории соответствующие напитки
        networkManager.getDrinks(type: "Ordinary_Drink", completion: { [weak self] (drinks, error) in
            if let error = error {
                print("ERROR: \(error)")
                return
            }
            
            guard let drinks = drinks else { return }
            self?.drinks = drinks
            self?.tableView.reloadData()
        })
    }
}

extension DrinksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = Bundle.main.loadNibNamed("DrinksCategoryTableViewCell", owner: self, options: nil)?.first as! DrinksCategoryTableViewCell
        headerView.titleLabel.text = drinksCategory[section].strCategory
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

extension DrinksViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return drinksCategory.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrinksCell", for: indexPath) as! DrinksTableViewCell
        let url = URL(string: drinks[indexPath.item].strDrinkThumb)
        
        cell.drinkImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        
        cell.nameLabel.text = drinks[indexPath.item].strDrink
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}


