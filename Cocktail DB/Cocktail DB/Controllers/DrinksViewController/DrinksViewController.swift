//
//  ViewController.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/14/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//

import UIKit
import SDWebImage
import Moya

protocol DataSourceDelegate {
    func didLoadCategories()
    func didLoadDrinksForSection(section: Int)
    func willLoadDrinks()
}

class DrinksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var dataSource = DrinksDataSource(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    private func setupViewController() {
        //        SVProgressHUD.show()
        dataSource.loadCategories()
        //        setupNavigationItems()
        registerTableViewClasses()
    }
    
    private func registerTableViewClasses() {
        tableView.register(DrinksTableViewCell.nib, forCellReuseIdentifier: DrinksTableViewCell.reuseIdentifier)
    }
}

extension DrinksViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = Bundle.main.loadNibNamed("DrinksCategoryTableViewCell", owner: self, options: nil)?.first as! DrinksCategoryTableViewCell
        let category = dataSource.categoryForSection(section)
        headerView.titleLabel.text = category.name?.uppercased() ?? "Empty"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
}

// MARK: - UITableViewDataSource

extension DrinksViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DrinksTableViewCell.reuseIdentifier, for: indexPath) as! DrinksTableViewCell
        
        let drink = dataSource.drinkForIndexPath(indexPath: indexPath)
        
        let url = URL(string: drink.imageUrl ?? "")
        
        cell.drinkImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        
        cell.nameLabel.text = drink.name ?? "Empty"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88.0
    }
}

// MARK: - DataSourceDelegate

extension DrinksViewController: DataSourceDelegate {
    func didLoadCategories() {
        tableView.reloadData()
        dataSource.loadDrinksByCategories(dataSource.getCategories())
    }
    
    func didLoadDrinksForSection(section: Int) {
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
        if section == dataSource.numberOfSections() - 1 {
            print("SVProgressHUD.dismiss()")
            //            SVProgressHUD.dismiss()
        }
    }
    
    func willLoadDrinks() {
        //      SVProgressHUD.show()
        tableView.reloadData()
    }
}
