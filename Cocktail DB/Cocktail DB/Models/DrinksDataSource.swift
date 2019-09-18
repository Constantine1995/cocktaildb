//
//  DrinksDataSource.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/17/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//

import Moya

class DrinksDataSource {
    
    // MARK: Properties

    private let drinksService = DrinkService()
    private var categories = [Category]()
    private var allCategories = [Category]()
    private var drinks = [[Drink]]()
    private let delegate: DataSourceDelegate
    
    // MARK: - Initialization
    
    init(delegate: DataSourceDelegate) {
        self.delegate = delegate
    }
    
    func loadCategories() {
        drinksService.fetchCategories {  [weak self] (response, error) in
            if let error = error {
                print("ERROR: \(error)")
                return
            }
            self?.categoriesDidLoad(response: response!)
        }
    }
    
    func loadDrinksByCategories(_ categories: [Category]) {
        
        var categoriesForLoad = categories
        guard !categoriesForLoad.isEmpty else { return }
        guard let category = categoriesForLoad.first else { return}
        drinksService.fetchDrinks(categoryName: category.strCategory ) { [weak self] (response, error) in
            
            if let error = error {
                print("ERROR: \(error)")
                return
            }
            categoriesForLoad.removeFirst()
            self?.drinksDidLoadForCategory(сategory: category, responce: response!)
            self?.loadDrinksByCategories(categoriesForLoad)
        }
    }

    //MARK - Helpers
    
    func getCategoriesNames() -> [String] {
        return categories.compactMap { $0.strCategory }
    }
    
    func numberOfSections() -> Int {
        return categories.count
    }
    
    func categoryForSection(_ section: Int) -> Category {
        return categories[section]
    }
    
    func getCategories() -> [Category] {
        return categories
    }
    
    func drinkForIndexPath(indexPath: IndexPath) -> Drink {
        let defaultDrink = Drink.init(strDrink: "", strDrinkThumb: "", idDrink: "")
        guard drinks.count > indexPath.section, drinks[indexPath.section].count > indexPath.row else { return defaultDrink}
        return drinks[indexPath.section][indexPath.row]
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        guard drinks.count > section else { return 0 }
        
        return drinks[section].count
    }
    
    func setCategoriesToFilter(from categoriesNames: [String]) {
        if categoriesNames.isEmpty {
            categories = allCategories
        } else {
            categories = allCategories.filter { categoriesNames.contains($0.strCategory ) }
        }
        
        drinks.removeAll()
        delegate.willLoadDrinks()
        loadDrinksByCategories(categories)
    }
    
    //MARK: - Data did load methods
    
    private func categoriesDidLoad(response: CategoriesList) {
        categories.removeAll()
        guard let categoriesFromServes = response.drinks else { return }
        allCategories = categoriesFromServes
        categories = categoriesFromServes
        delegate.didLoadCategories()
    }
    
    private func drinksDidLoadForCategory(сategory: Category, responce: DrinkList) {
        guard let section = categories.firstIndex(of: сategory),
            let drinksForSection = responce.drinks else { return }
        drinks.append(drinksForSection)
        delegate.didLoadDrinksForSection(section: section)
    }
}
