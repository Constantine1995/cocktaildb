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

protocol DataSourceDelegate {
    func didLoadCategories()
    func didLoadDrinksForSection(section: Int)
    func willLoadDrinks()
}

class DrinksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var dataSource = DrinksDataSource(delegate: self)

    var drinksCategory: [DrinksCategory] = []
    var drinks: [Drinks] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        
        let drinkCellNib = UINib(nibName: "DrinksTableViewCell", bundle: nil)
        tableView.register(drinkCellNib, forCellReuseIdentifier: "DrinksCell")
        
        // Получение категорий, передача в массив и далее вывод на экран
        //        networkManager.getDrinksCategory { [weak self] (drinks, error) in
        //
        //            if let error = error {
        //                print("ERROR: \(error)")
        //                return
        //            }
        //            guard let drinks = drinks else { return }
        //
        //            self?.drinksCategory = drinks
        //            self?.tableView.reloadData()
        //        }
        //
        // Получение напитков для каждой категории (type -  передается название напитка, посдтавляется в параметры ссылки)
        // Не знаю каким образом можно отобразить для каждой категории соответствующие напитки
        //        networkManager.getDrinks(type: "Ordinary_Drink", completion: { [weak self] (drinks, error) in
        //            if let error = error {
        //                print("ERROR: \(error)")
        //                return
        //            }
        //
        //            guard let drinks = drinks else { return }
        //            self?.drinks = drinks
        //            self?.tableView.reloadData()
        //        })
    }
    
    private func setupViewController() {
//        SVProgressHUD.show()
        dataSource.loadCategories()
//        setupNavigationItems()
//        registerTableViewClasses()
    }
    
    private func categoriesDidLoad(response: Categories) {
//        categories.removeAll()
//        guard let categoriesFromServes = response.list else { return }
//
//        allCategories = categoriesFromServes
//        categories = categoriesFromServes
//        delegate.didLoadCategories()
    }
    
}

extension DrinksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = Bundle.main.loadNibNamed("DrinksCategoryTableViewCell", owner: self, options: nil)?.first as! DrinksCategoryTableViewCell
        let category = dataSource.categoryForSection(section)
        headerView.titleLabel.text = category.name?.uppercased() ?? NSLocalizedString("Empty name", comment: "")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

extension DrinksViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return dataSource.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrinksCell", for: indexPath) as! DrinksTableViewCell
        let drink = dataSource.drinkForIndexPath(indexPath: indexPath)

        let url = URL(string: drink.imageUrl ?? "")

        cell.drinkImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))

        cell.nameLabel.text = drink.name ?? NSLocalizedString("Empty", comment: "")

        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 70
//    }
}


// MARK: - DataSourceDelegate

extension DrinksViewController: DataSourceDelegate {
    func didLoadCategories() {
        tableView.reloadData()
        dataSource.loadDrinksByCategories(dataSource.getCategories())
    }
    
    func didLoadDrinksForSection(section: Int) {
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
//        if section == dataSource.numberOfSections() - 1 {
//            SVProgressHUD.dismiss()
//        }
    }
    
    func willLoadDrinks() {
//        SVProgressHUD.show()
        tableView.reloadData()
    }
}
