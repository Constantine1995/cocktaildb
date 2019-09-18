//
//  ViewController.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/14/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD
import PPBadgeViewSwift

protocol DataSourceDelegate {
    func didLoadCategories()
    func didLoadDrinksForSection(section: Int)
    func willLoadDrinks()
}

class DrinksViewController: UIViewController {
    
    // MARK: - Properties & IBOutlets

    @IBOutlet weak var tableView: UITableView!
    
    private lazy var dataSource = DrinksDataSource(delegate: self)
    
    let heightForHeaderInSection: CGFloat = 44.0
    let heightForRowAt: CGFloat = 88.0
  
    // MARK: - Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    private func configureViewController() {
        SVProgressHUD.show()
        dataSource.loadCategories()
        configureTableView()
        configureNavigationItems()
    }
    
    private func configureTableView() {
        tableView.register(DrinksTableViewCell.nib, forCellReuseIdentifier: DrinksTableViewCell.reuseIdentifier)
        tableView.register(DrinkCategoryHeader.nib, forHeaderFooterViewReuseIdentifier: DrinkCategoryHeader.reuseIdentifier)

    }
    
    private func configureNavigationItems() {
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "filterImage"), style: .plain, target: self, action: #selector(filtersButtonPressed))
        navigationItem.rightBarButtonItem = rightBarButton
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc private func filtersButtonPressed() {
        routeToFilters()
    }
    
    private func isRightBarbuttonItemBadgeHidden(_ value: Bool) {
        guard let rightBarButton = self.navigationItem.rightBarButtonItem else { return }
        
        value ? rightBarButton.pp.addDot(color: .red) : rightBarButton.pp.hiddenBadge()
    }
    
    private func routeToFilters() {
        let filters = dataSource.getCategoriesNames()
        guard !filters.isEmpty else { return }
        let filtersViewController = FiltersViewController.create(with: filters, delegate: self)
        self.navigationController?.pushViewController(filtersViewController, animated: true)
    }
}

// MARK: - UITableViewDelegate

extension DrinksViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: DrinkCategoryHeader.reuseIdentifier) as? DrinkCategoryHeader
        let category = dataSource.categoryForSection(section)
        headerView?.categoryLabel.text = category.strCategory.uppercased()        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightForHeaderInSection
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
        
        let url = URL(string: drink.strDrinkThumb )
        
        cell.drinkImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        
        cell.nameLabel.text = drink.strDrink
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRowAt
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
         SVProgressHUD.dismiss()
        }
    }
    
    func willLoadDrinks() {
        SVProgressHUD.show()
        tableView.reloadData()
    }
}

// MARK: - DrinksViewControllerDeleghate

extension DrinksViewController: FiltersViewControllerDelegate {
    func filtersDidChange(filters: [String]) {
        isRightBarbuttonItemBadgeHidden(!filters.isEmpty)
        dataSource.setCategoriesToFilter(from: filters)
    }
}
